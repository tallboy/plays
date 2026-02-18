# Common Pitfalls: Frontend UI Engineering

## Pitfall 1: Div Soup

**Symptom:** Excessive nested divs instead of semantic HTML

**Bad:**
```jsx
<div className="header">
  <div className="nav">
    <div className="nav-item" onClick={handleClick}>Home</div>
  </div>
</div>
```

**Good:**
```jsx
<header>
  <nav>
    <button onClick={handleClick}>Home</button>
  </nav>
</header>
```

**Fix:** Use semantic elements: `<button>`, `<nav>`, `<article>`, `<section>`, `<header>`, `<footer>`, `<main>`, `<aside>`

**Prevention:** Ask "Is there a semantic HTML element for this?" before using `<div>`

---

## Pitfall 2: Missing Keyboard Support

**Symptom:** Custom controls don't respond to Tab, Enter, Escape

**Bad:**
```jsx
<div onClick={handleClick} className="button">Click me</div>
```

**Good:**
```jsx
<button onClick={handleClick}>Click me</button>

// OR for custom control:
<div
  role="button"
  tabIndex={0}
  onClick={handleClick}
  onKeyPress={(e) => {
    if (e.key === 'Enter' || e.key === ' ') handleClick();
  }}
>
  Click me
</div>
```

**Fix:** Use native elements or add ARIA roles + keyboard handlers

**Prevention:** Test every interactive element with keyboard only (no mouse)

---

## Pitfall 3: Color-Only Information

**Symptom:** Red/green for error/success with no other indicator

**Bad:**
```jsx
<span style={{ color: 'red' }}>Error occurred</span>
<span style={{ color: 'green' }}>Success!</span>
```

**Good:**
```jsx
<span className="error">
  <IconError aria-hidden="true" />
  Error occurred
</span>
<span className="success">
  <IconCheck aria-hidden="true" />
  Success!
</span>
```

**Fix:** Add icons, text labels, or patterns in addition to color

**Prevention:** Test UI in grayscale mode or with color blindness simulator

---

## Pitfall 4: Layout Shift (CLS)

**Symptom:** Content jumps when images/fonts load

**Bad:**
```jsx
<img src="/avatar.jpg" alt="User avatar" />
```

**Good:**
```jsx
<img
  src="/avatar.jpg"
  alt="User avatar"
  width={40}
  height={40}
  loading="lazy"
/>

// OR with Next.js Image
<Image
  src="/avatar.jpg"
  alt="User avatar"
  width={40}
  height={40}
  placeholder="blur"
/>
```

**Fix:**
- Specify width/height on images
- Use `font-display: swap` for web fonts
- Reserve space for dynamic content

**Prevention:** Measure CLS with Lighthouse, aim for < 0.1

---

## Pitfall 5: Prop Drilling

**Symptom:** Passing props through 5+ levels of components

**Bad:**
```jsx
<App user={user}>
  <Layout user={user}>
    <Sidebar user={user}>
      <UserMenu user={user} />
    </Sidebar>
  </Layout>
</App>
```

**Good:**
```jsx
// Use Context
const UserContext = createContext();

<UserContext.Provider value={user}>
  <App>
    <Layout>
      <Sidebar>
        <UserMenu />  {/* Uses useContext(UserContext) */}
      </Sidebar>
    </Layout>
  </App>
</UserContext.Provider>
```

**Fix:** Use Context API, composition, or state management library (Zustand, Redux)

**Prevention:** If passing same prop through 3+ levels, refactor to Context

---

## Pitfall 6: Not Handling Loading/Error States

**Symptom:** Component shows nothing while loading or on error

**Bad:**
```jsx
function UserProfile({ userId }) {
  const { data } = useUser(userId);
  return <div>{data.name}</div>;  // Crashes if data is undefined
}
```

**Good:**
```jsx
function UserProfile({ userId }) {
  const { data, loading, error } = useUser(userId);

  if (loading) return <Spinner />;
  if (error) return <ErrorMessage error={error} />;
  if (!data) return <NotFound />;

  return <div>{data.name}</div>;
}
```

**Fix:** Always handle loading, error, and empty states

**Prevention:** Use pattern: loading → error → empty → data

---

## Pitfall 7: Missing Focus Management

**Symptom:** Opening modal doesn't trap focus, closing doesn't restore it

**Bad:**
```jsx
{isOpen && (
  <div className="modal">
    <button onClick={onClose}>Close</button>
    <div>{content}</div>
  </div>
)}
```

**Good:**
```jsx
function Modal({ isOpen, onClose, children }) {
  const modalRef = useRef();

  useFocusTrap(modalRef, isOpen);  // Trap focus inside modal
  useKeyPress('Escape', onClose, isOpen);  // Close on Escape

  useEffect(() => {
    if (isOpen) {
      const previousFocus = document.activeElement;
      return () => previousFocus.focus();  // Restore focus on close
    }
  }, [isOpen]);

  if (!isOpen) return null;

  return (
    <div ref={modalRef} role="dialog" aria-modal="true">
      {children}
      <button onClick={onClose}>Close</button>
    </div>
  );
}
```

**Fix:** Trap focus in modals, restore focus on close

**Prevention:** Test all modals/dialogs with keyboard navigation

---

## Pitfall 8: Unnecessary Re-renders

**Symptom:** Component re-renders on every parent update even when props unchanged

**Bad:**
```jsx
function Parent() {
  const [count, setCount] = useState(0);
  const data = { value: count };  // New object every render

  return (
    <>
      <button onClick={() => setCount(count + 1)}>Increment</button>
      <ExpensiveChild data={data} />  {/* Re-renders every time */}
    </>
  );
}
```

**Good:**
```jsx
function Parent() {
  const [count, setCount] = useState(0);
  const data = useMemo(() => ({ value: count }), [count]);

  return (
    <>
      <button onClick={() => setCount(count + 1)}>Increment</button>
      <ExpensiveChild data={data} />  {/* Only re-renders when count changes */}
    </>
  );
}

const ExpensiveChild = memo(function ExpensiveChild({ data }) {
  // Expensive rendering
});
```

**Fix:** Use `useMemo` for objects/arrays, `useCallback` for functions, `memo` for expensive components

**Prevention:** Use React DevTools Profiler to find unnecessary re-renders
