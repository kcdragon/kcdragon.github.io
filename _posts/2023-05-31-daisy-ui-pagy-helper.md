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
    p_prev = pagy.prev
    p_next = pagy.next

    html = +%(<nav#{p_id} class="btn-group">)
    html << if p_prev
              %(<a class="btn" href="#{pagy_url_for(pagy, p_prev, html_escaped: true)}" aria-label="previous" #{link_extra}>#{pagy_t('pagy.nav.prev')}</a> )
            else
              %(<a class="btn btn-disabled" #{link_extra}>#{pagy_t('pagy.nav.prev')}</a> )
            end
    pagy.series(**vars).each do |item| # series example: [1, :gap, 7, 8, "9", 10, 11, :gap, 36]
      html << case item
              when Integer then %(<a class="btn" href="#{pagy_url_for(pagy, item, html_escaped: true)}" #{link_extra}>#{item}</a> )
              when String  then %(<a class="btn btn-active" #{link_extra}>#{pagy.label_for(item)}</a> )
              when :gap    then %(<a class="btn btn-disabled" #{link_extra}>#{pagy_t('pagy.nav.gap')}</a> )
              else raise InternalError, "expected item types in series to be Integer, String or :gap; got #{item.inspect}"
              end
    end
    html << if p_next
              %(<a class="btn" href="#{pagy_url_for(pagy, p_next, html_escaped: true)}" aria-label="next" #{link_extra}>#{pagy_t('pagy.nav.next')}</a>)
            else
              %(<a class="btn btn-disabled" #{link_extra}>#{pagy_t('pagy.nav.next')}</a>)
            end
    html << %(</nav>)
  end
end
```

Here's what it looks like.

<img src="/assets/daisy-ui-pagy.png" />
