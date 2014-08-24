---
layout: post
title:  "Steel City Ruby '14 Recap - Part 1"
date:   2014-08-23
tags: ruby scrc scrc14 conference jruby rake functional
---
Last weekend I attended my first Ruby conference, Steely City Ruby in Pittsburgh, PA. I learned a lot of the two-day conference and had a lot of fun along the way. Four co-workers and I left Thursday night from Philadelphia. We gave one of the speakers at the conference, [Austin Seraphin](https://twitter.com/AustinSeraphin), a ride out. He is an iOS accessibility consultant and developer of some pretty cool command line tools for interacting with iOS and RubyMotion. We got into Pittsburgh late that night and went right to sleep in preparation of next morning's talks.

Here are my highlights from the first day:

# JRuby: The Best Parts by Charles Nutter
I knew a little about JRuby before the conference, but this talk by the creator of the implementation, gave me a lot of insight into the reasons someone would choose it over MRI. The first "best part" that stuck out to me was that the virtual machine it uses (the Java Virtual Machine) is more mature than any other virtual machine since it has been optimized over the years. The second "best part" was that JRuby utilizes Java threads and can run multiple threads concurrently unlike MRI. He also highlighted two common complaints with JRuby: slow startup and lack of C-extensions. He addressed slow startup by suggestion a tool called drip that preloads new JVM instances. There was an experiment at adding support for C-extensions but there were too many issues with it.

# Utils is a Junk Drawer by Franklin Weber
Franklin talked a lot about util classes that could be utilzed across projects. The example that stuck out the most to me was from Rake.

{% highlight ruby %}
# from https://github.com/jimweirich/rake/blob/master/lib/rake/ext/string.rb
class String
  rake_extension("ext") do
    def ext(newext='')
      ...
    end
  end
end

# from https://github.com/jimweirich/rake/blob/master/lib/rake/ext/core.rb
class Module
  def rake_extension(method)
    if method_defined?(method)
      $stderr.puts "WARNING: Possible conflict with Rake extension: " +
        "#{self}##{method} already exists"
    else
      yield
    end
  end
end
{% endhighlight %}

The idea behind this code is to a `rake_extension` call around a core method that you are redefining to notify the developer if the method has already been created by another Gem.

# Better Coding with Ruby Lambdas by Keith Bennett
Keith talked about the various uses of lambda's and how they are under-utilized when compared to normal methods. I particularly liked his use of lambdas to create "inner methods". This technique reminds me a lot of Scala inner methods. When a method needs to call several other function, instead of creating private methods, local lambdas can be created.

{% highlight ruby %}
# from https://github.com/keithrbennett/ruby-lambdas-presentation-notes/blob/master/inner_functions__lambdas.rb
class SampleUsingLambdas

  def task_1

    validate_inputs = ->() do
      ...
    end

    perform = ->() do
      ...
    end

    cleanup = ->() do
      ...
    end

    validate_inputs.()
    perform.()
    cleanup.()
  end
end

# instead of

class SampleUsingLambdas

  def task_1
    validate_inputs
    perform
    cleanup
  end

  private

  def validate_inputs
    ...
  end

  def perform
    ...
  end

  def cleanup
    ...
  end
end
{% endhighlight %}

After the talks were over for the day, we headed to the conference reception at PNC Park (where the Pittsburgh Pirates play). They had great food and a great view waiting for us.

![Steel City Ruby Reception at PNC Park](/assets/steel-city-ruby-pnc-park.jpg)
