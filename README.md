# Rib

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
docker build -t rib .
```


### There is no Containerfile here! Why you do not make this podman compatible?

A `Containerfile` is a `Dockerfile` with a different name. And, those are
just default names `podman build` and `docker build` look for, respectively.
If you want, rename the `Dockerfile` to `Containerfile`, or make it an alias,
and then it is business as usual:

```bash
podman build -t rib .
```

But, you do not have to be tied down to using default filenames. You can
feed the build process a custom file using the `-f` option:

```bash
podman build -t rib -f Dockerfile .
```

Don't like to call it `Dockerfile`? Call it `secondbanana`! It does not care!

```bash
podman build -t rib -f secondbanana .
```

## Using it.

We are not running the container as an app like they say you should.
Instead, we will be running a shell through it.

You will want to pass the directory you use to develop your backaged as a 
volume to the container; for this example, let's call it `~/dev/c/packagetest`.
Like others, I try not to run containers as root; the user (inside the 
container) that is created to do the building deed is called `lamdeving`.
Don't like it? Edit the Dockerfile and change it!

Now, the directory inside the container that the volume is mounted to is
`/home/iamdeving/build`; you can change it on the command line if 
it pleases you. For instance, some will prefer to use `/home/iamdeving` so 
to keep their history and envornment. It is up to you.

**NOTE:** Unfortunately as of now you must run it using the `--privileged`
option because of some mounts the `mock` package do need that, and I have not 
figured out a workaround yet. 
I too do not like it but for now we need to run the container in an insecure 
manner like that, both in `docker` and `podman`.
The only good thing is this is a short-lived container without exposed 
network ports, so the kind of attacks it is exposed to is not as large
as some may claim.

```bash
docker run -i --rm --privileged -v ~/dev/c/packagetest:/home/iamdeving/build -e EXTGID=$(id -g) -t rib bash
```

Once it is running, you can test it by following the examples shown in 
a [blog article](https://skip.linuxdn.org/blog.html#005_Rocky5_BuildLab_Part1
) put together
by one of the developers. I myself use it when testing this container.
If you are running the first example (building `bash`), and are following
my directory structure, put everything inside the `~/build` directory instead
of the homedir. Then you will unleash mock (note I am being explicit about the
paths):

```bash
mock -v --resultdir=~/build/rockybuild/bash   --buildsrpm --spec=~/build/rockysrc/bash/SPECS/bash.spec  --sources=~/build/rockysrc/bash/SOURCES/
``` 

This will take a while; I may add the time here later.
If all goes well, you should end up with a new shiny package and some logs
(the `nobody` happens because this directory is in a NFS fileshare):


```bash
[iamdeving@626bc2975526 build]$ ls -lh rockybuild/bash/                    
total 9.2M                                                                      
-rw-r--r-- 1 nobody extgroup 9.1M Aug 31 17:25 bash-4.4.20-4.el8.src.rpm    
-rw-rw-r-- 1 nobody extgroup 1.2K Aug 31  2023 build.log                   
-rw-rw-r-- 1 nobody extgroup 1.5K Aug 31  2023 hw_info.log                 
-rw-rw-r-- 1 nobody extgroup  67K Aug 31  2023 root.log                     
-rw-rw-r-- 1 nobody extgroup 1.1K Aug 31  2023 state.log                    
[iamdeving@626bc2975526 build]$
```

If not, go back and see if you find where it went boink. If you can't, ask
in the dev support for, say, Fedora or Rocky Linux.

## Cleaning up after yourself

After you are done, just exit the container; it will die automagically but
your work will not be lost, as it is in the dev directory you fed to the
container as a volume.
I suggest to update the container's packages every so often unless you have
a reason to keep the versions around.

## Why did you rename it as rib?

Rib is a lightweight version of Mock. 
