---
layout: post
title:  "Cleaning up ElasticSearch indexes with RSpec and Tire"
date:   2013-10-06
categories: elasticsearch rspec tire
---
I started a new project and had a need for cleaning up ElasticSearch indexes during testing. I wanted to do something similar to DatabaseCleaner or Mongoid.purge! in the spec_helper file.

The problem was that I didn't want to delete all my indexes because I had indexes for other projects on my computer that I didn't want to delete. I figured that I needed a way to keep track of all the indexes created and then delete them prior to the next test. I also wanted to avoid including this logic in all my spec files.

Here is the relevant code from my spec_helper file. This is from the RSpec.configure block.

{% highlight ruby %}
indexes = []
meta_class = class << Tire::Index; self; end
meta_class.send(:alias_method, :__new__, :new)
meta_class.send(:define_method, :new) do |*args|
  indexes << args.first
  __new__(*args)
end

config.before(:each) do
  indexes.each { |index| Tire::Index.__new__(index).delete }
  indexes = []
end
{% endhighlight %}

The idea is to keep track of all indexes by overriding the constructor to keep track of all the names. It's not perfect; instantiating a Tire::Index does not necessarily mean it is created.

It seems pretty hackish and I would be really interested if someone had a better idea. One alternative that comes to mind is keeping track of all indexes that exist in config.before and then removing all the ones that aren't in that list in config.after. With this alternative, however, you need to make sure no other indexes are being created by another application.
