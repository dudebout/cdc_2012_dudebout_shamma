#Empirical-evidence Equilibria in Stochastic Games
**Nicolas Dudebout and Jeff S. Shamma**

##Abstract
The framework of empirical-evidence equilibrium (EEE) for stochastic games is developed in this paper.
In a stochastic game, agents collectively influence the dynamic of the environment.
In standard equilibria, each agent's strategy is optimal with respect to its opponents' strategies.
Therefore, each strategy is the solution to a partially observable Markov decision process (POMDP).
The following considerations motivate the notion of EEE.
First, solutions to a POMDP can be prohibitively complex to compute and implement.
Second, agents might not fully understand the environment's dynamic.
Third, standard equilibria do not accommodate different levels of bounded rationality among agents.
Finally, reaching equilibrium in stochastic games has not been adequately addressed.
In the EEE framework, each agent formulates a simple model of its opponents' effects.
It neglects that agents are mutually dependent through the environment and computes an optimal strategy associated with its model.
The agents play their strategies against each other and make some observations.
Agents are in EEE when the models are consistent with these empirical observations.
In this paper, the notion of EEE is formalized and an existence result is established in a general setting.
Relations with other equilibria, including mean-field equilibria, are also presented.
Finally, the learning of EEEs by simple adaptive processes is illustrated through simulation.

##BibTeX
    @InProceedings{dudebout_shamma:2012,
      author       = "Dudebout, Nicolas and Shamma, Jeff S.",
      title        = "Empirical Evidence Equilibria in Stochastic Games",
      booktitle    = "51st IEEE Conference on Decision and Control",
      year         = 2012,
      pages        = "5780-5785",
      month        = dec
    }

##Copyright
© 2012 IEEE.
Personal use of this material is permitted.
Permission from IEEE must be obtained for all other uses, in any current or future media, including reprinting/republishing this material for advertising or promotional purposes, creating new collective works, for resale or redistribution to servers or lists, or reuse of any copyrighted component of this work in other works.
