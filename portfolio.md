---
layout: page
title: Portfolio
permalink: /portfolio/
---

# [Mongration](http://www.github.com/kcdragon/mongration)

Mongration is an open source database migration tool for MongoDB. It designed to be included as a Gem in any Ruby project. I developed Mongration while working with MongoDB and realizing I still had a need for migrations. MongoDB does not require migrations for schema changes however there are still times when you need to change field names, create lookup tables, etc. and having a standardized way of doing it proved invaluable. Mongration has the same interface as ActiveRecord migrations so it fits in nicely with other Gems that make use of ActiveRecord's Rake tasks (like deploying with Capistrano).
