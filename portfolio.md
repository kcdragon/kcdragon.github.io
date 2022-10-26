---
layout: page
title: Portfolio
permalink: /portfolio/
---

# [Game Stats AI](https://gamestats.ai/)

Game Stats AI is a SaaS application I've been building for game developers.
Game developers use it to collect data from users of their games and gain insights from that data.
For example, a developer for a digital card game can send match results to Game Stats AI and determine the win rates of each card.
This allows the developer to address cards with higher than expected win rates.

The web app is built with Ruby on Rails, PostgreSQL, Stimulus and other technologies.

![Game Stats AI](/assets/game-stats-ai.png)

# Computation Graph Viz

[Live App](https://mikedalton.co/computation-graph-viz/), [Source Code](https://github.com/kcdragon/computation-graph-viz)

Computation Graph Viz is a visualization for computation graphs and backpropagation.
It was my final project for the Education Technology class in Georgia Tech's Online Master of Science in Computer Science program.
The project is built with React, D3, Math.js and MathJax.

![Computation Graph Viz](/assets/computation-graph-viz.png)

# Mongration

[Source Code](https://github.com/kcdragon/mongration)

Mongration is an open source database migration tool for MongoDB. It designed to be included as a Gem in any Ruby project. I developed Mongration while working with MongoDB and realizing I still had a need for migrations. MongoDB does not require migrations for schema changes however there are still times when you need to change field names, create lookup tables, etc. and having a standardized way of doing it proved invaluable. Mongration has the same interface as ActiveRecord migrations so it fits in nicely with other Gems that make use of ActiveRecord's Rake tasks (like deploying with Capistrano).
