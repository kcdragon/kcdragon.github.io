---
layout: post
title: Pagy Frontend Helper for DaisyUI
tags: ruby rails pagy daisyui
---

I've been using [DaisyUI](https://daisyui.com/) for a new Rails app.
I'm using [Pagy](https://github.com/ddnexus/pagy) for pagination but wanted to use DaisyUI components to match the rest of my app. 
Here's the helper method I'm using. 
It's used the same way as the built in Pagy helpers. It was easy to adapt `pagy_nav` for DaisyUI.

```ruby
module DaisyUiPagyHelper
  def pagy_daisy_ui_nav(pagy, pagy_id: nil, link_extra: '', **vars)
    p_id   = %( id="#{pagy_id}") if pagy_id
    link   = pagy_link_proc(pagy, link_extra: link_extra)
    p_prev = pagy.prev
    p_next = pagy.next

    html = +%(<nav#{p_id} class="btn-group">)
    html << if p_prev
              %(<button class="btn">#{link.call p_prev, pagy_t('pagy.nav.prev'), 'aria-label="previous"'}</button> )
            else
              %(<button class="btn btn-disabled">#{pagy_t('pagy.nav.prev')}</button> )
            end
    pagy.series(**vars).each do |item| # series example: [1, :gap, 7, 8, "9", 10, 11, :gap, 36]
      html << case item
              when Integer then %(<button class="btn">#{link.call item}</button> )
              when String  then %(<button class="btn btn-active">#{pagy.label_for(item)}</button> )
              when :gap    then %(<button class="btn btn-disabled">#{pagy_t('pagy.nav.gap')}</button> )
              else raise InternalError, "expected item types in series to be Integer, String or :gap; got #{item.inspect}"
              end
    end
    html << if p_next
              %(<button class="btn">#{link.call p_next, pagy_t('pagy.nav.next'), 'aria-label="next"'}</button>)
            else
              %(<button class="btn btn-disabled">#{pagy_t('pagy.nav.next')}</button>)
            end
    html << %(</nav>)
  end
end
```

Here's what it looks like.

<img src="/assets/daisy-ui-pagy.png" />
