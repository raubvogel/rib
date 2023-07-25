# buildarocky

Here we go again, using containers to create an environment to build things;
As some of my repos hinted at, I seem to do that a lot.
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

**Warning:** building this image takes a lot of space, as in I was
running out of space. So I had to split the build process
as of now, we are talking about 2.41GB with docker

```bash
REPOSITORY              TAG            IMAGE ID       CREATED         SIZE
buildarocky             latest         4af69d17a78d   4 hours ago     2.41GB
<none>                  <none>         880008159c88   2 days ago      2.41GB
<none>                  <none>         74267c2382ae   2 days ago      2.41GB
```

and podman taking a bit more. These are seriously large images; my normal ones
temd to be under 50MB.

```bash
REPOSITORY              TAG            IMAGE ID       CREATED         SIZE
buildarocky             latest         4af69d17a78d   22 hours ago    2.55GB
```

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

