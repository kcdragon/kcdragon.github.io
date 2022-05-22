---
layout: post
title:  "Adding Functionality to your Ruby Code"
date:   2016-09-16
tags: ruby functional procedural ecommerce weblinc
---

This is a blog post I wrote while working at [WebLinc](http://www.weblinc.com).
It was posted on their blog until they shutdown their blog.

## Adding Functionality to your Ruby Code

Many programmers start out with languages that favor procedural programming. Because of this, it is tempting to use procedural constructs (while and .each loops) when writing an algorithm in Ruby, even though there may be clearer ways to express the algorithm. This blog post will describe several problems, and compare a procedural implementation and a functional implementation.

### Overview

Let’s start with some definitions and a simple example. The example we will use below is the common, but simple, problem of summing a list of numbers. We begin with a list of numbers and the result is the number that is equal to adding all elements of the list together.

### Procedural programming

> Procedural programming uses a list of instructions to tell the computer what to do step-by-step
> — http://study.com/academy/lesson/object-oriented-programming-vs-procedural-programming.html

A procedural implementation to sum a list of numbers would look something like this.

```ruby
sum = 0
[1, 2, 3].each do |number|
  sum += number
end
```

We start out by initializing a local variable to keep track of the sum. We then iterate through the list of numbers and add each number to the sum.

### Functional programming

> Functional programming is a programming paradigm … that treats computation as the evaluation of mathematical functions and avoids changing-state and mutable data
> — https://en.wikipedia.org/wiki/Functional_programming

A functional implementation for the list summation problem would be to “reduce” the list by adding each number to an accumulator.

```ruby
sum = [1, 2, 3].reduce(0) do |sum, number|
  sum + number
end
```

The difference between the two implementations is that functional programming does not require the sum variable to be altered as the algorithm progresses.

This is a very simple example, so it might not be clear yet what the advantages are of a functional approach. Let’s look at a more complicated example to see how functional and procedural programming compare in a practical application.

### Free Item Discount Example

#### Background

Discounts are essential on ecommerce websites, and WebLinc’s platform supports many different kinds. One of the more popular discounts is the free item discount. The specific free item discount we will discuss is a “Buy 2 of X and/or Y, Get 1 Z”. The discount can be stated more generically as “Buy N from a list of products and Get 1 of the free product”.

#### Implementation Overview

A discount is applied to a cart which is a collection of items. We will represent an item in the cart with this item class.

```ruby
Item = Struct.new(:product_id, :quantity)
```

A real cart item has many more fields (price, product name), but for this example we will only focus on the product ID and the quantity. The product ID will be used to represent the X, Y and Z in “Buy 2 of X and/or Y Get 1 Z”. The quantity is necessary because multiples of the same product can contribute to the discount.

Each implementation of the free item discount will conform to the following abstract class.

```ruby
class FreeItemDiscount
 
  # @param free_item_product_id
  #   Product ID for the Free Item
  #
  # @param product_ids
  #   The Product IDs that qualify for the discount
  #
  # @param quantity
  #   The quantity of product_ids that must be in the list of items
  #     in order to qualify for the discount
  #

  def initialize(free_item_product_id, product_ids, quantity)
    @free_item_product_id = free_item_product_id
    @product_ids = product_ids
    @quantity = quantity
  end

  def free_item(items: [])
    raise "#{self.class.to_s} must implement #free_item"
  end

  def qualifies?(items: [])
    raise "#{self.class.to_s} must implement #qualifies?"
  end

  private

  def item_qualifies?(item)
    @product_ids.include?(item.product_id)
  end

end
```

In addition to the two abstract methods free_item and qualifies?, we define a helper method, item_qualifies?, which is used in each implementation. This method returns true if the item’s product ID is in the list of the discount’s eligible product IDs. We will focus our discussion on the implementation of qualifies?.

#### Procedural Implementation

The procedural implementation of qualifies? creates two local variables to keep track of whether or not the discount qualifies (does_qualify), and the quantity of items that qualify for the discount (quantity_of_qualifying_items)

While iterating through the items we check to see if the item qualifies for the discount. If the item does qualify for the discount, we increment the quantity_of_qualifying_items counter by the quantity of that item. Once we have the updated quantity_of_qualifying_items, we check to see if that quantity is greater than the quantity of items needed to qualify for the discount. If this quantity is greater, the cart qualifies for the discount and we can stop iterating.

```ruby
class ProceduralFreeItemDiscount < FreeItemDiscount

  def qualifies?(items: [])
    does_qualify = false
    quantity_of_qualifying_items = 0
    items.each do |item|
      if item_qualifies?(item)
        quantity_of_qualifying_items += item.quantity
      end

      if quantity_of_qualifying_items >= quantity_needed_per_discount
        does_qualify = true
        break
      end
    end
    does_qualify
  end

  private

  def quantity_needed_per_discount
    @quantity
  end 

end
```

#### Functional Implementation

The functional implementation of qualifies? checks to see if the discountable_quantity is greater than 0. The discountable_quantity is equal to the number_of_qualifying_items in the cart divided by the discount’s eligible quantity. We calculate the number_of_qualifying_items by adding together the quantity of all qualifying items.

```ruby
class FunctionalFreeItemDiscount < FreeItemDiscount

  def qualifies?(items: [])
    discountable_quantity(items) > 0
  end
  private

  def discountable_quantity(items)
    number_of_qualifying_items(items) / @quantity
  end

  def number_of_qualifying_items(items)
    qualifying_items(items).sum(&:quantity)
  end

  def qualifying_items(items)
    items.select do |item|
      item_qualifies?(item)
    end
  end

end
```

#### Comparison of Implementations

The procedural and functional approaches implement the same method and return the same results, but the code is quite different. The procedural implementation modifies several state variables while iterating through the list of items, and it will break when it determines that it qualifies for the discount. The functional implementation does not use any state variables and, at each step of the algorithm, returns an object (either an integer or an array).

The advantage of the procedural implementation is that it takes a step-by-step approach that is intuitive for many developers. However, it is difficult to understand each step independent of each other since each step of the algorithm requires something being done before it.

The functional implementation steps are easier to distinguish from one another since they are separate methods. The code is self-documenting with method names. The code is easier to debug since you can use a single method call to evaluate the result at each step.

### Recommendations

It is important to remember that each approach is useful in different situations. One approach that I’ve been successful with is starting out by implementing an algorithm procedurally. This is often the most intuitive way to write the algorithm, especially if you are following test-driven development. After finishing the implementation, I try out a functional approach. I’ve found that when I am returning to look at my own code, or reading someone else’s, it is easier to read and re-use functional code.

See [GitHub](https://github.com/weblinc/functional-programming-discounts-blog-post) for source code of the discounts used in this post.
