Seethe
===
Complect complexity and churn for a given path to locate problem areas in your Ruby applications.

Complexity is calculated using Flog for ABC metrics, with a configurable minimum complexity score. Methods with scores below the cutoff are discarded, and the average of the remaining methods is taken.

Churn is currently a simplistic count of commits per file.

Files exceeding both the complexity score and churn count values are reported.

Installation
---
```bash
gem install seethe
```

Usage
---
Seethe expects to be run from inside your project directory, which must be a git repository.

```bash
cd <project dir>
seethe
```

You may also specify a subdirectory of your project and override the default complexity score/churn counts.

```bash
seethe [sub directory] [complexity cut off (default 60)] [churn cut off (default 10)]

# Report on all Rails views with no cutoff
seethe app/views 0 0

# Report on entire Rails app, looking for high churn
seethe . 0 50

```

Credits
---
- [Flog](http://ruby.sadi.st/Flog.html) for ABC metrics
- [James Martin](https://coderwall.com/p/qdrt3g/getting-empirical-about-complexity-in-templates) — For doing the heavy lifting converting ERB into floggable source.
