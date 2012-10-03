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

To generate the paper, the TEXMFHOME environment variable needs to contain `./texmf`.
If the variable already contains a path, it can be updated as follows:

    $ TEXMFHOME='{<current_texmfhome_value$,./texmf}'

Else the variable can be created as follows:

    $ export TEXMFHOME=./texmf
