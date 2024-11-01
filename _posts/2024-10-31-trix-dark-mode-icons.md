---
layout: post
title: Trix Dark Mode Icons in Jumpstart Pro
tags: ruby rails trix jumpstartpro
---

This snippet changes the [Trix editor](https://trix-editor.org/) icons to white when dark mode is enabled in Jumpstart Pro.

```css
.dark .trix-button--icon {
  -webkit-filter: invert(100%);
}
```

<img src="/assets/trix-dark-mode-css.png" />
