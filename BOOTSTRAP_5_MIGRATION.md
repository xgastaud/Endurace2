# Bootstrap 5 Migration Guide

## Summary

Your application has been upgraded from Bootstrap 3.4.1 to Bootstrap 5.3.8. This is a major upgrade that includes significant breaking changes.

## What Was Changed

### Dependencies Updated

**npm packages:**
- ✅ `bootstrap`: 3.4.1 → **5.3.8**
- ✅ Added `@popperjs/core`: **^2.11.8** (required for Bootstrap 5 tooltips, popovers, dropdowns)

**Ruby gems:**
- ✅ Removed `bootstrap-sass` (no longer needed)

### Files Created/Modified

**Created:**
- `app/javascript/stylesheets/application.scss` - New Bootstrap 5 style entry point

**Modified:**
- `app/javascript/entrypoints/application.js` - Now imports Bootstrap 5 JS and styles
- `package.json` - Updated Bootstrap version

## Breaking Changes & Required Updates

Bootstrap 5 introduces many breaking changes. Here are the most common ones you'll need to address:

### 1. jQuery Removed

Bootstrap 5 **no longer requires jQuery**. All Bootstrap JavaScript components now use vanilla JavaScript.

**Action Required:**
- If you have code that initializes Bootstrap components with jQuery (e.g., `$('#myModal').modal('show')`), you need to update it to use Bootstrap 5's JavaScript API.

**Old (Bootstrap 3):**
```javascript
$('#myModal').modal('show');
$('[data-toggle="tooltip"]').tooltip();
```

**New (Bootstrap 5):**
```javascript
const myModal = new bootstrap.Modal(document.getElementById('myModal'));
myModal.show();

// Or using data attributes (still works):
// <button data-bs-toggle="modal" data-bs-target="#myModal">Open</button>
```

### 2. Data Attribute Changes

All data attributes have been renamed from `data-*` to `data-bs-*`.

**Action Required:**
Search your views for these patterns and update them:

| Bootstrap 3 | Bootstrap 5 |
|-------------|-------------|
| `data-toggle` | `data-bs-toggle` |
| `data-target` | `data-bs-target` |
| `data-dismiss` | `data-bs-dismiss` |
| `data-placement` | `data-bs-placement` |
| `data-slide` | `data-bs-slide` |
| `data-ride` | `data-bs-ride` |
| `data-parent` | `data-bs-parent` |

**Example:**
```erb
<!-- OLD (Bootstrap 3) -->
<button data-toggle="modal" data-target="#myModal">Open</button>

<!-- NEW (Bootstrap 5) -->
<button data-bs-toggle="modal" data-bs-target="#myModal">Open</button>
```

### 3. Grid System Changes

**Removed:** `.col-xs-*` classes
**Action Required:** Replace with `.col-*` (they're now mobile-first by default)

```html
<!-- OLD -->
<div class="col-xs-12 col-sm-6">

<!-- NEW -->
<div class="col-12 col-sm-6">
```

### 4. Form Classes

Form styling has changed significantly:

| Bootstrap 3 | Bootstrap 5 |
|-------------|-------------|
| `.form-group` | `.mb-3` (or use spacing utilities) |
| `.help-block` | `.form-text` |
| `.input-group-addon` | `.input-group-text` |
| `.input-group-btn` | (removed, place buttons directly in `.input-group`) |
| `.form-control-feedback` | `.invalid-feedback` / `.valid-feedback` |
| `.has-error`, `.has-success` | `.is-invalid`, `.is-valid` |

**Example:**
```erb
<!-- OLD (Bootstrap 3) -->
<div class="form-group has-error">
  <%= f.text_field :email, class: 'form-control' %>
  <span class="help-block">Error message</span>
</div>

<!-- NEW (Bootstrap 5) -->
<div class="mb-3">
  <%= f.text_field :email, class: 'form-control is-invalid' %>
  <div class="invalid-feedback">Error message</div>
</div>
```

### 5. Button Classes

**Removed:** `.btn-default`
**Action Required:** Use `.btn-secondary` instead

```html
<!-- OLD -->
<button class="btn btn-default">Button</button>

<!-- NEW -->
<button class="btn btn-secondary">Button</button>
```

### 6. Card Component

`.panel`, `.panel-heading`, `.panel-body` have been replaced with `.card` components:

```html
<!-- OLD (Bootstrap 3) -->
<div class="panel panel-default">
  <div class="panel-heading">Title</div>
  <div class="panel-body">Content</div>
</div>

<!-- NEW (Bootstrap 5) -->
<div class="card">
  <div class="card-header">Title</div>
  <div class="card-body">Content</div>
</div>
```

### 7. Modal Changes

Modals now have different wrapper structure:

```html
<!-- OLD (Bootstrap 3) -->
<div class="modal">
  <div class="modal-dialog">
    <div class="modal-content">
      ...
    </div>
  </div>
</div>

<!-- NEW (Bootstrap 5) - Same structure, but check data attributes! -->
<div class="modal" id="myModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Title</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      ...
    </div>
  </div>
</div>
```

Note: `.close` button is now `.btn-close`

### 8. Utility Classes

Many utility classes have been renamed or changed:

| Bootstrap 3 | Bootstrap 5 |
|-------------|-------------|
| `.pull-left` | `.float-start` |
| `.pull-right` | `.float-end` |
| `.text-left` | `.text-start` |
| `.text-right` | `.text-end` |
| `.hidden-xs` | `.d-none .d-sm-block` |
| `.visible-xs` | `.d-block .d-sm-none` |
| `.navbar-right` | `.ms-auto` (margin-start: auto) |
| `.center-block` | `.mx-auto` |

### 9. Navbar Changes

Navbar structure has changed:

```html
<!-- OLD (Bootstrap 3) -->
<nav class="navbar navbar-default">
  <div class="navbar-header">
    <button class="navbar-toggle" data-toggle="collapse" data-target="#navbar">
      <span class="icon-bar"></span>
    </button>
  </div>
  <div class="collapse navbar-collapse" id="navbar">
    ...
  </div>
</nav>

<!-- NEW (Bootstrap 5) -->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <button class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#navbar">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbar">
      ...
    </div>
  </div>
</nav>
```

### 10. Responsive Images

```html
<!-- OLD -->
<img src="..." class="img-responsive">

<!-- NEW -->
<img src="..." class="img-fluid">
```

## Testing Checklist

After migration, test these components:

- [ ] **Modals** - Open/close functionality
- [ ] **Dropdowns** - Click to open/close
- [ ] **Tooltips** - Hover to display
- [ ] **Popovers** - Click to display
- [ ] **Forms** - Validation states and styling
- [ ] **Buttons** - All button variants render correctly
- [ ] **Navbar** - Mobile collapse/expand
- [ ] **Grids** - Responsive layouts on mobile/tablet/desktop
- [ ] **Cards** - If using panels, ensure cards display correctly
- [ ] **Alerts** - Dismissible alerts work
- [ ] **Tabs** - Tab switching functionality
- [ ] **Carousel** - If used, test slide transitions

## Recommended Migration Steps

1. **Start with views:**
   ```bash
   # Find all data-toggle occurrences
   grep -r "data-toggle" app/views/

   # Find all Bootstrap 3 specific classes
   grep -r "col-xs-" app/views/
   grep -r "pull-left\|pull-right" app/views/
   grep -r "panel panel-" app/views/
   ```

2. **Update data attributes:**
   - Replace `data-toggle` with `data-bs-toggle`
   - Replace `data-target` with `data-bs-target`
   - Replace `data-dismiss` with `data-bs-dismiss`

3. **Update JavaScript:**
   - Search for jQuery-based Bootstrap initialization
   - Replace with Bootstrap 5 JavaScript API

4. **Update CSS classes:**
   - Replace `.col-xs-*` with `.col-*`
   - Replace `.pull-*` with `.float-*`
   - Replace `.panel` with `.card`
   - Replace `.btn-default` with `.btn-secondary`

5. **Test thoroughly:**
   - Test on mobile, tablet, and desktop
   - Test all interactive components
   - Check browser console for errors

## Resources

- [Official Bootstrap 5 Migration Guide](https://getbootstrap.com/docs/5.3/migration/)
- [Bootstrap 5 Documentation](https://getbootstrap.com/docs/5.3/getting-started/introduction/)
- [Bootstrap 5 Examples](https://getbootstrap.com/docs/5.3/examples/)

## Current Status

✅ Bootstrap 5.3.8 installed
✅ Styles configured
✅ JavaScript configured
⚠️  **View templates need manual migration**
⚠️  **Custom JavaScript may need updates**

## Security Benefits

- ✅ **No more XSS vulnerabilities** from Bootstrap 3
- ✅ Up-to-date, actively maintained version
- ✅ Better security practices built-in
