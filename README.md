# buildarocky

Here we go again, using containers to create an environment to build things;
As some of my repos hinted at, I seem to do a lot of that.
This time it is an environment to build packages for Rocky Linux.
Of course this should also work (in principle) with Alma Linux or CentOS
(maybe even Fedora), but I need to start somewhere, right?
Babysteps.

Rocky already has a 
[nice setup](https://github.com/rocky-linux/devtools) already, 
which was put together by people who have a clue (i.e. not yours truly),
but it looked too complicated for little me. All I wanted is something
I can plop some software in, and build the package for it.

## Warning

This is a work in progress. Use with caution. This side up. If it
causes your computer to catch fire, post the video up somewhere.

## Building it

Even if I make a prebuilt image available, I will always show how to build
it on your own. The reason is security: if you build it, you know what is
being put in it.

The simplest way to build it is doing
```bash
docker build -t buildarocky .
```

Warning: building this image takes a lot of space; 
I am still trying to find ways shrink it down.

### There is no Containerfile here! Why you do not make this podman compatible?

A `Containerfile` is a `Dockerfile` with a different name. And, those are
just default names `podman build` and `docker build` look for, respectively.
If you want, rename the `Dockerfile` to `Containerfile`, or make it an alias,
and then it is business as usual:

```bash
podman build -t buildarocky .
```

But, you do not have to be tied down to using default filenames. You can
feed the build process a custom file using the `-f` option:

```bash
podman build -t buildarocky -f Dockerfile
```

Don't like to call it `Dockerfile`? Call it `secondbanana`! It does not care!

```bash
podman build -t buildarocky -f secondbanana
```

## Using it.

You will want to pass a volume to it. I will fill this session later.

