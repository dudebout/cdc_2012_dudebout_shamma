After cloning the repository, the submodules need to be populated.
This is done with the following command:

    $ git submodule update --init

To generate the simulation data, the dependencies for `game-theoretic-learning` have to be installed.
One way to do so is as follows:

    $ cd simulations
    $ hsenv
    $ source .hsenv_simulations/bin/activate
    $ cd game-theoretic-learning
    $ cabal install --only-dependencies

The Makefile generating the paper modifies the TEXMFHOME environment variable to contain `./texmf`.
To combine your TEXMFHOME with the Makefile one you can use the following command:

    $ export TEXMFHOMEREQUIRED=$TEXMFHOME
