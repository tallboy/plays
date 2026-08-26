# Advanced: Frontend UI Engineering

## Advanced Pattern 1: Compound Components

Allow components to share state implicitly without prop drilling.

```typescript
// components/organisms/Tabs/Tabs.tsx
import { createContext, useContext, useState } from 'react';

interface TabsContextValue {
  activeTab: string;
  setActiveTab: (tab: string) => void;
}

const TabsContext = createContext<TabsContextValue | undefined>(undefined);

function useTabs() {
  const context = useContext(TabsContext);
  if (!context) {
    throw new Error('Tab components must be used within Tabs');
  }
  return context;
}

export function Tabs({ defaultTab, children }: {
  defaultTab: string;
  children: React.ReactNode;
}) {
  const [activeTab, setActiveTab] = useState(defaultTab);

  return (
    <TabsContext.Provider value={{ activeTab, setActiveTab }}>
      <div role="tablist">{children}</div>
    </TabsContext.Provider>
  );
}

export function TabList({ children }: { children: React.ReactNode }) {
  return <div role="tablist">{children}</div>;
}

export function Tab({ value, children }: {
  value: string;
  children: React.ReactNode;
}) {
  const { activeTab, setActiveTab } = useTabs();
  const isActive = activeTab === value;

  return (
    <button
      role="tab"
      aria-selected={isActive}
      aria-controls={`panel-${value}`}
      onClick={() => setActiveTab(value)}
    >
      {children}
    </button>
  );
}

export function TabPanels({ children }: { children: React.ReactNode }) {
  return <div>{children}</div>;
}

export function TabPanel({ value, children }: {
  value: string;
  children: React.ReactNode;
}) {
  const { activeTab } = useTabs();
  if (activeTab !== value) return null;

  return (
    <div role="tabpanel" id={`panel-${value}`}>
      {children}
    </div>
  );
}

// Usage
<Tabs defaultTab="profile">
  <TabList>
    <Tab value="profile">Profile</Tab>
    <Tab value="settings">Settings</Tab>
  </TabList>
  <TabPanels>
    <TabPanel value="profile">Profile content</TabPanel>
    <TabPanel value="settings">Settings content</TabPanel>
  </TabPanels>
</Tabs>
```

---

## Advanced Pattern 2: Render Props for Logic Reuse

```typescript
// components/utilities/DataFetcher.tsx
interface DataFetcherProps<T> {
  url: string;
  children: (state: {
    data: T | null;
    loading: boolean;
    error: Error | null;
    refetch: () => void;
  }) => React.ReactNode;
}

export function DataFetcher<T>({ url, children }: DataFetcherProps<T>) {
  const [data, setData] = useState<T | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  const fetchData = useCallback(async () => {
    setLoading(true);
    try {
      const response = await fetch(url);
      const json = await response.json();
      setData(json);
      setError(null);
    } catch (err) {
      setError(err as Error);
    } finally {
      setLoading(false);
    }
  }, [url]);

  useEffect(() => {
    fetchData();
  }, [fetchData]);

  return <>{children({ data, loading, error, refetch: fetchData })}</>;
}

// Usage
<DataFetcher<User> url="/api/user/123">
  {({ data, loading, error, refetch }) => {
    if (loading) return <Spinner />;
    if (error) return <ErrorMessage error={error} onRetry={refetch} />;
    if (!data) return <NotFound />;
    return <UserProfile user={data} />;
  }}
</DataFetcher>
```

---

## Advanced Pattern 3: Polymorphic Components

Components that can render as different HTML elements.

```typescript
// components/atoms/Box/Box.tsx
import { ElementType, ComponentPropsWithoutRef } from 'react';

type BoxProps<T extends ElementType> = {
  as?: T;
  className?: string;
  children?: React.ReactNode;
} & ComponentPropsWithoutRef<T>;

export function Box<T extends ElementType = 'div'>({
  as,
  className,
  children,
  ...props
}: BoxProps<T>) {
  const Component = as || 'div';
  return (
    <Component className={className} {...props}>
      {children}
    </Component>
  );
}

// Usage
<Box>Renders as div</Box>
<Box as="section">Renders as section</Box>
<Box as="a" href="/home">Renders as link</Box>
<Box as={Link} to="/home">Renders as React Router Link</Box>
```

---

## Advanced Pattern 4: Animation with Framer Motion

```typescript
// components/molecules/Accordion/Accordion.tsx
import { motion, AnimatePresence } from 'framer-motion';
import { useState } from 'react';

interface AccordionItemProps {
  title: string;
  children: React.ReactNode;
}

export function AccordionItem({ title, children }: AccordionItemProps) {
  const [isOpen, setIsOpen] = useState(false);

  return (
    <div>
      <button
        onClick={() => setIsOpen(!isOpen)}
        aria-expanded={isOpen}
      >
        {title}
        <motion.span
          animate={{ rotate: isOpen ? 180 : 0 }}
          transition={{ duration: 0.2 }}
        >
          ▼
        </motion.span>
      </button>
      <AnimatePresence>
        {isOpen && (
          <motion.div
            initial={{ height: 0, opacity: 0 }}
            animate={{ height: 'auto', opacity: 1 }}
            exit={{ height: 0, opacity: 0 }}
            transition={{ duration: 0.3 }}
          >
            {children}
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  );
}
```

---

## Advanced Pattern 5: Optimistic UI Updates

```typescript
// hooks/useOptimisticUpdate.ts
import { useState, useCallback } from 'react';

export function useOptimisticUpdate<T>(
  initialData: T,
  updateFn: (newData: T) => Promise<T>
) {
  const [data, setData] = useState(initialData);
  const [isUpdating, setIsUpdating] = useState(false);
  const [error, setError] = useState<Error | null>(null);

  const update = useCallback(
    async (newData: T) => {
      const previousData = data;

      // Optimistically update UI
      setData(newData);
      setIsUpdating(true);
      setError(null);

      try {
        const result = await updateFn(newData);
        setData(result);
      } catch (err) {
        // Rollback on error
        setData(previousData);
        setError(err as Error);
      } finally {
        setIsUpdating(false);
      }
    },
    [data, updateFn]
  );

  return { data, isUpdating, error, update };
}

// Usage
function TodoItem({ todo }: { todo: Todo }) {
  const { data, update } = useOptimisticUpdate(
    todo,
    async (updated) => {
      const response = await fetch(`/api/todos/${todo.id}`, {
        method: 'PATCH',
        body: JSON.stringify(updated),
      });
      return response.json();
    }
  );

  const toggleComplete = () => {
    update({ ...data, completed: !data.completed });
  };

  return (
    <div>
      <input
        type="checkbox"
        checked={data.completed}
        onChange={toggleComplete}
      />
      {data.title}
    </div>
  );
}
```

---

## Advanced Pattern 6: Error Boundaries

```typescript
// components/utilities/ErrorBoundary.tsx
import { Component, ErrorInfo, ReactNode } from 'react';

interface Props {
  children: ReactNode;
  fallback?: ReactNode;
  onError?: (error: Error, errorInfo: ErrorInfo) => void;
}

interface State {
  hasError: boolean;
  error: Error | null;
}

export class ErrorBoundary extends Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { hasError: false, error: null };
  }

  static getDerivedStateFromError(error: Error): State {
    return { hasError: true, error };
  }

  componentDidCatch(error: Error, errorInfo: ErrorInfo) {
    console.error('ErrorBoundary caught:', error, errorInfo);
    this.props.onError?.(error, errorInfo);
  }

  render() {
    if (this.state.hasError) {
      return (
        this.props.fallback || (
          <div role="alert">
            <h2>Something went wrong</h2>
            <details>
              <summary>Error details</summary>
              <pre>{this.state.error?.message}</pre>
            </details>
          </div>
        )
      );
    }

    return this.props.children;
  }
}

// Usage
<ErrorBoundary
  fallback={<ErrorFallback />}
  onError={(error) => {
    logErrorToService(error);
  }}
>
  <App />
</ErrorBoundary>
```

---

## Advanced Pattern 7: Code Splitting by Route

```typescript
// App.tsx
import { lazy, Suspense } from 'react';
import { Routes, Route } from 'react-router-dom';

// Lazy load route components
const Dashboard = lazy(() => import('./pages/Dashboard'));
const Analytics = lazy(() => import('./pages/Analytics'));
const Settings = lazy(() => import('./pages/Settings'));

function App() {
  return (
    <Suspense fallback={<LoadingSpinner fullScreen />}>
      <Routes>
        <Route path="/" element={<Dashboard />} />
        <Route path="/analytics" element={<Analytics />} />
        <Route path="/settings" element={<Settings />} />
      </Routes>
    </Suspense>
  );
}
```

---

## Performance Optimization Techniques

### 1. Virtualization for Large Lists

Use `react-window` or `react-virtualized` for lists with 100+ items.

### 2. Debounce/Throttle Expensive Operations

```typescript
import { useDebouncedCallback } from 'use-debounce';

function SearchInput() {
  const [query, setQuery] = useState('');

  const debouncedSearch = useDebouncedCallback(
    async (value: string) => {
      const results = await searchAPI(value);
      setResults(results);
    },
    500  // Wait 500ms after user stops typing
  );

  return (
    <input
      value={query}
      onChange={(e) => {
        setQuery(e.target.value);
        debouncedSearch(e.target.value);
      }}
    />
  );
}
```

### 3. Progressive Image Loading

```typescript
import { useState } from 'react';

function ProgressiveImage({ src, placeholder }: {
  src: string;
  placeholder: string;
}) {
  const [loaded, setLoaded] = useState(false);

  return (
    <div style={{ position: 'relative' }}>
      <img
        src={placeholder}
        alt=""
        style={{
          filter: loaded ? 'blur(0)' : 'blur(10px)',
          transition: 'filter 0.3s',
        }}
      />
      <img
        src={src}
        alt=""
        onLoad={() => setLoaded(true)}
        style={{
          position: 'absolute',
          top: 0,
          left: 0,
          opacity: loaded ? 1 : 0,
          transition: 'opacity 0.3s',
        }}
      />
    </div>
  );
}
```

### 4. Intersection Observer for Lazy Loading

```typescript
import { useEffect, useRef, useState } from 'react';

export function useInView(options?: IntersectionObserverInit) {
  const ref = useRef<HTMLDivElement>(null);
  const [isInView, setIsInView] = useState(false);

  useEffect(() => {
    const element = ref.current;
    if (!element) return;

    const observer = new IntersectionObserver(([entry]) => {
      setIsInView(entry.isIntersecting);
    }, options);

    observer.observe(element);
    return () => observer.disconnect();
  }, [options]);

  return { ref, isInView };
}

// Usage
function LazyImage({ src, alt }: { src: string; alt: string }) {
  const { ref, isInView } = useInView({ rootMargin: '200px' });

  return (
    <div ref={ref}>
      {isInView ? (
        <img src={src} alt={alt} loading="lazy" />
      ) : (
        <div style={{ width: 300, height: 200, background: '#eee' }} />
      )}
    </div>
  );
}
```
