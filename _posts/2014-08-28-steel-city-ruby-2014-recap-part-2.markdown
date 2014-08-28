---
layout: post
title:  "Steel City Ruby '14 Recap - Part 2"
date:   2014-08-28
tags: ruby scrc conference entrepreneurship action_view testing
---

(see [Steel City Ruby '14 - Part 1](/2014/08/23/steel-city-ruby-2014-recap-part-1/) for my thoughts on the first day of the conference)

# "Entrepreneurship for Engineers" by Bryan Helmkamp
The creator of Code Climate gave a talk on starting a business as an engineer. He discussed the various kinds of businesses an engineer could start (freelance, B2B (business to business), B2C (business to consumer), social networks, etc.) and the level of difficulty with finding customers (freelancing being on the easier end and social networks being on the higher end of the spectrum). His recommendation? Build a B2B service and find 150 customers who will pay $67/month.

# "The Metaphysics of Strings" by Greg Gates
In Rails, any Strings have there HTML escaped unless they are marked as HTML safe. The #html_safe method is responsible for marking a String as HTML safe. Greg talked about how this method can produce strange results when concatenating safe and non-safe strings.

His first example showed that a safe string and a non-safe string are considered equal.

{% highlight ruby %}
irb(main):001:0> require 'action_view'
=> true
irb(main):002:0> safe_string = "I am a string".html_safe
=> "I am a string"
irb(main):003:0> not_safe_string = "I am a string"
=> "I am a string"
irb(main):004:0> safe_string == not_safe_string
=> true
irb(main):005:0> not_safe_string == safe_string
=> true
{% endhighlight %}

His second example showed that, even though strings of equal contents were equal regardless of safe-ness, the order in which they were concatenated determined if the resulting string was considered safe.

{% highlight ruby %}
irb(main):001:0> require 'action_view'
=> true
irb(main):002:0> safe_string = "Safe String".html_safe
=> "Safe String"
irb(main):003:0> not_safe_string = "Not Safe String"
=> "Not Safe String"
irb(main):004:0> (safe_string + not_safe_string).html_safe?
=> true
irb(main):005:0> (not_safe_string + safe_string).html_safe?
=> false
{% endhighlight %}

# "Generative Testing for Better Code" by Jessica Kerr
This was the final talk of the conference and the organizers couldn't have picked a better talk to end with. Generative testing, instead of example-based testing, uses randomized inputs and then after application is run with these randomized input verifies that a set of properties hold true. In a standard example-based test, the input would be fixed (the same every time the test is run) and the expected behavior would be well-defined. Generative testing is a little more difficult since the input is not determined until the test is run and it may be difficult to know the expected behavior when writing the test.

From her abstract:

> The goal of Generative Testing is to carefully define every possible input, then let the framework run hundreds of scenarios through the same test. It means thinking about more than a few examples, and deciding what the code should do in every possible situation.

Even though Generative Testing is more mature in other languages, she gave some examples in Ruby using the library [rantly](https://github.com/hayeah/rantly). This repository has some examples she went through during the talk [https://github.com/jessitron/venn](https://github.com/jessitron/venn).

# After the conference

I had a lot of fun at my first Ruby conference and I am looking forward to attending more in the future. I definitely would recommend this conference to anyone in the future. They have a great Ruby community in Pittsburgh and they put a lot of time and effort into making it a great weekend for those who attended.
