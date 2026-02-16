# Examples: Frontend UI Engineering

## Example 1: Production-Ready Button Component

```typescript
// components/atoms/Button/Button.tsx
import { ButtonHTMLAttributes, forwardRef } from 'react';
import { clsx } from 'clsx';
import styles from './Button.module.css';

export interface ButtonProps extends ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: 'primary' | 'secondary' | 'ghost';
  size?: 'sm' | 'md' | 'lg';
  loading?: boolean;
  leftIcon?: React.ReactNode;
  rightIcon?: React.ReactNode;
}

export const Button = forwardRef<HTMLButtonElement, ButtonProps>(
  (
    {
      variant = 'primary',
      size = 'md',
      loading = false,
      disabled,
      leftIcon,
      rightIcon,
      children,
      className,
      ...props
    },
    ref
  ) => {
    return (
      <button
        ref={ref}
        className={clsx(
          styles.button,
          styles[variant],
          styles[size],
          loading && styles.loading,
          className
        )}
        disabled={disabled || loading}
        aria-busy={loading}
        {...props}
      >
        {loading && <Spinner className={styles.spinner} aria-hidden="true" />}
        {!loading && leftIcon && <span aria-hidden="true">{leftIcon}</span>}
        <span>{children}</span>
        {!loading && rightIcon && <span aria-hidden="true">{rightIcon}</span>}
      </button>
    );
  }
);

Button.displayName = 'Button';
```

**Test:**
```typescript
// Button.test.tsx
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { Button } from './Button';

describe('Button', () => {
  it('renders with text', () => {
    render(<Button>Click me</Button>);
    expect(screen.getByRole('button', { name: /click me/i })).toBeInTheDocument();
  });

  it('calls onClick when clicked', async () => {
    const handleClick = jest.fn();
    render(<Button onClick={handleClick}>Click me</Button>);

    await userEvent.click(screen.getByRole('button'));
    expect(handleClick).toHaveBeenCalledTimes(1);
  });

  it('is disabled when loading', () => {
    render(<Button loading>Click me</Button>);
    expect(screen.getByRole('button')).toBeDisabled();
    expect(screen.getByRole('button')).toHaveAttribute('aria-busy', 'true');
  });

  it('is keyboard accessible', async () => {
    const handleClick = jest.fn();
    render(<Button onClick={handleClick}>Click me</Button>);

    const button = screen.getByRole('button');
    button.focus();
    expect(button).toHaveFocus();

    await userEvent.keyboard('{Enter}');
    expect(handleClick).toHaveBeenCalled();
  });
});
```

**Storybook:**
```typescript
// Button.stories.tsx
import type { Meta, StoryObj } from '@storybook/react';
import { Button } from './Button';
import { IconSearch } from '../icons';

const meta: Meta<typeof Button> = {
  title: 'Atoms/Button',
  component: Button,
  tags: ['autodocs'],
};

export default meta;
type Story = StoryObj<typeof Button>;

export const Primary: Story = {
  args: {
    children: 'Primary Button',
    variant: 'primary',
  },
};

export const WithIcon: Story = {
  args: {
    children: 'Search',
    leftIcon: <IconSearch />,
  },
};

export const Loading: Story = {
  args: {
    children: 'Loading...',
    loading: true,
  },
};
```

---

## Example 2: Accessible Form Field

```typescript
// components/molecules/FormField/FormField.tsx
import { InputHTMLAttributes, useId } from 'react';
import { Input } from '../../atoms/Input';
import { Label } from '../../atoms/Label';
import styles from './FormField.module.css';

export interface FormFieldProps extends InputHTMLAttributes<HTMLInputElement> {
  label: string;
  error?: string;
  helperText?: string;
  required?: boolean;
}

export function FormField({
  label,
  error,
  helperText,
  required,
  id,
  ...inputProps
}: FormFieldProps) {
  const generatedId = useId();
  const fieldId = id || generatedId;
  const errorId = `${fieldId}-error`;
  const helperId = `${fieldId}-helper`;

  return (
    <div className={styles.formField}>
      <Label htmlFor={fieldId} required={required}>
        {label}
      </Label>
      <Input
        id={fieldId}
        aria-invalid={!!error}
        aria-describedby={
          error ? errorId : helperText ? helperId : undefined
        }
        aria-required={required}
        {...inputProps}
      />
      {error && (
        <span id={errorId} className={styles.error} role="alert">
          {error}
        </span>
      )}
      {!error && helperText && (
        <span id={helperId} className={styles.helper}>
          {helperText}
        </span>
      )}
    </div>
  );
}
```

**Usage:**
```tsx
<form onSubmit={handleSubmit}>
  <FormField
    label="Email"
    type="email"
    required
    error={errors.email}
    helperText="We'll never share your email"
  />
  <FormField
    label="Password"
    type="password"
    required
    error={errors.password}
  />
  <Button type="submit">Sign in</Button>
</form>
```

---

## Example 3: Accessible Dialog/Modal

```typescript
// components/organisms/Dialog/Dialog.tsx
import { useEffect, useRef } from 'react';
import { createPortal } from 'react-dom';
import { useKeyPress } from '../../../hooks/useKeyPress';
import { useFocusTrap } from '../../../hooks/useFocusTrap';
import styles from './Dialog.module.css';

export interface DialogProps {
  open: boolean;
  onClose: () => void;
  title: string;
  children: React.ReactNode;
  actions?: React.ReactNode;
}

export function Dialog({ open, onClose, title, children, actions }: DialogProps) {
  const dialogRef = useRef<HTMLDivElement>(null);
  const previousFocusRef = useRef<HTMLElement | null>(null);

  // Trap focus within dialog
  useFocusTrap(dialogRef, open);

  // Close on Escape
  useKeyPress('Escape', onClose, open);

  // Manage focus and body scroll
  useEffect(() => {
    if (open) {
      previousFocusRef.current = document.activeElement as HTMLElement;
      document.body.style.overflow = 'hidden';

      return () => {
        document.body.style.overflow = '';
        previousFocusRef.current?.focus();
      };
    }
  }, [open]);

  if (!open) return null;

  return createPortal(
    <div className={styles.overlay} onClick={onClose}>
      <div
        ref={dialogRef}
        className={styles.dialog}
        role="dialog"
        aria-modal="true"
        aria-labelledby="dialog-title"
        onClick={(e) => e.stopPropagation()}
      >
        <header className={styles.header}>
          <h2 id="dialog-title">{title}</h2>
          <button
            className={styles.closeButton}
            onClick={onClose}
            aria-label="Close dialog"
          >
            ×
          </button>
        </header>
        <div className={styles.content}>{children}</div>
        {actions && <footer className={styles.footer}>{actions}</footer>}
      </div>
    </div>,
    document.body
  );
}
```

**Custom Hooks:**
```typescript
// hooks/useFocusTrap.ts
import { useEffect } from 'react';

export function useFocusTrap(
  ref: React.RefObject<HTMLElement>,
  enabled: boolean
) {
  useEffect(() => {
    if (!enabled || !ref.current) return;

    const element = ref.current;
    const focusableElements = element.querySelectorAll<HTMLElement>(
      'button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])'
    );
    const firstElement = focusableElements[0];
    const lastElement = focusableElements[focusableElements.length - 1];

    const handleTab = (e: KeyboardEvent) => {
      if (e.key !== 'Tab') return;

      if (e.shiftKey) {
        if (document.activeElement === firstElement) {
          e.preventDefault();
          lastElement?.focus();
        }
      } else {
        if (document.activeElement === lastElement) {
          e.preventDefault();
          firstElement?.focus();
        }
      }
    };

    element.addEventListener('keydown', handleTab);
    firstElement?.focus();

    return () => {
      element.removeEventListener('keydown', handleTab);
    };
  }, [ref, enabled]);
}

// hooks/useKeyPress.ts
import { useEffect } from 'react';

export function useKeyPress(
  key: string,
  callback: () => void,
  enabled = true
) {
  useEffect(() => {
    if (!enabled) return;

    const handleKeyPress = (e: KeyboardEvent) => {
      if (e.key === key) {
        callback();
      }
    };

    window.addEventListener('keydown', handleKeyPress);
    return () => window.removeEventListener('keydown', handleKeyPress);
  }, [key, callback, enabled]);
}
```

---

## Example 4: Virtualized Data Table

```typescript
// components/organisms/DataTable/DataTable.tsx
import { FixedSizeList } from 'react-window';
import styles from './DataTable.module.css';

export interface Column<T> {
  key: keyof T;
  header: string;
  sortable?: boolean;
  render?: (value: T[keyof T], row: T) => React.ReactNode;
}

export interface DataTableProps<T> {
  data: T[];
  columns: Column<T>[];
  caption: string;
  rowHeight?: number;
  height?: number;
}

export function DataTable<T extends { id: string | number }>({
  data,
  columns,
  caption,
  rowHeight = 48,
  height = 600,
}: DataTableProps<T>) {
  const Row = ({ index, style }: { index: number; style: React.CSSProperties }) => {
    const row = data[index];
    return (
      <div style={style} className={styles.row} role="row">
        {columns.map((column) => (
          <div key={String(column.key)} className={styles.cell} role="cell">
            {column.render
              ? column.render(row[column.key], row)
              : String(row[column.key])}
          </div>
        ))}
      </div>
    );
  };

  return (
    <div role="table" aria-label={caption} className={styles.table}>
      <div role="rowgroup" className={styles.thead}>
        <div role="row" className={styles.headerRow}>
          {columns.map((column) => (
            <div key={String(column.key)} role="columnheader" className={styles.header}>
              {column.header}
            </div>
          ))}
        </div>
      </div>
      <div role="rowgroup">
        <FixedSizeList
          height={height}
          itemCount={data.length}
          itemSize={rowHeight}
          width="100%"
        >
          {Row}
        </FixedSizeList>
      </div>
    </div>
  );
}
```

**Usage:**
```tsx
const columns: Column<User>[] = [
  { key: 'name', header: 'Name', sortable: true },
  { key: 'email', header: 'Email' },
  {
    key: 'status',
    header: 'Status',
    render: (status) => (
      <span className={`badge ${status}`}>{status}</span>
    ),
  },
];

<DataTable
  data={users}
  columns={columns}
  caption="User list"
  rowHeight={48}
  height={600}
/>
```

---

## Example 5: Design Tokens Setup

```typescript
// tokens/colors.ts
export const colors = {
  primary: {
    50: '#eff6ff',
    500: '#3b82f6',
    700: '#1d4ed8',
  },
  semantic: {
    error: '#dc2626',
    warning: '#f59e0b',
    success: '#10b981',
    info: '#3b82f6',
  },
  text: {
    primary: '#1f2937',
    secondary: '#6b7280',
    disabled: '#9ca3af',
  },
  background: {
    primary: '#ffffff',
    secondary: '#f9fafb',
  },
} as const;

// tokens/spacing.ts
export const spacing = {
  xs: '0.25rem',
  sm: '0.5rem',
  md: '1rem',
  lg: '1.5rem',
  xl: '2rem',
} as const;

// tokens/typography.ts
export const typography = {
  fonts: {
    sans: 'Inter, system-ui, sans-serif',
    mono: 'Fira Code, monospace',
  },
  sizes: {
    xs: '0.75rem',
    sm: '0.875rem',
    base: '1rem',
    lg: '1.125rem',
    xl: '1.25rem',
  },
  weights: {
    normal: 400,
    medium: 500,
    semibold: 600,
    bold: 700,
  },
} as const;
```

**CSS Variables:**
```css
/* tokens.css */
:root {
  /* Colors */
  --color-primary-500: #3b82f6;
  --color-error: #dc2626;
  --color-success: #10b981;

  /* Spacing */
  --spacing-sm: 0.5rem;
  --spacing-md: 1rem;
  --spacing-lg: 1.5rem;

  /* Typography */
  --font-sans: Inter, system-ui, sans-serif;
  --font-size-base: 1rem;
  --font-weight-normal: 400;
}

/* Usage */
.button {
  padding: var(--spacing-md);
  font-family: var(--font-sans);
  background: var(--color-primary-500);
}
```

---

## Example 6: Responsive Image Component

```typescript
// components/atoms/ResponsiveImage/ResponsiveImage.tsx
import { ImgHTMLAttributes } from 'react';

interface ResponsiveImageProps extends ImgHTMLAttributes<HTMLImageElement> {
  src: string;
  alt: string;
  width: number;
  height: number;
  sources?: {
    media: string;
    srcSet: string;
  }[];
}

export function ResponsiveImage({
  src,
  alt,
  width,
  height,
  sources = [],
  ...props
}: ResponsiveImageProps) {
  return (
    <picture>
      {sources.map((source, index) => (
        <source key={index} media={source.media} srcSet={source.srcSet} />
      ))}
      <img
        src={src}
        alt={alt}
        width={width}
        height={height}
        loading="lazy"
        decoding="async"
        {...props}
      />
    </picture>
  );
}
```

**Usage:**
```tsx
<ResponsiveImage
  src="/images/hero-mobile.webp"
  alt="Hero image"
  width={375}
  height={250}
  sources={[
    {
      media: "(min-width: 1024px)",
      srcSet: "/images/hero-desktop.webp",
    },
    {
      media: "(min-width: 768px)",
      srcSet: "/images/hero-tablet.webp",
    },
  ]}
/>
```
