# DC Optimal Power Flow using Gurobi (yep, finally.)

When I started learning power flow analysis in my undergrad, I stumbled upon the limitation of my potato brain to understand the basics of the power flow. 
Back then, there were no references to the optimization program of the economic dispatch or OPF specifically.
So, to help you guys who want to learn the basics of optimization, I present you my ~~not-finest~~ creation that I made in my spare time, sometimes when I am asleep too.

This program uses Python 3.8 with the modules as follows:\
`pandas`, `matplotlib`, `math`, `networkx`, `pypower`, `gurobipy`

The network parameters are obtained from the `pypower` datasets, which are adjusted based on their format. For now, some cases throw an error (e.g., case24_rts, case57, case118, case300) due to double transmission lines between two buses that mess up the naming of the variable indices.\
To use `gurobipy`, Gurobi should be installed in the machine with a valid license (hey, a student's license is very cool!). Please read its documentation to understand how the code works fully.\
This program is made to be as simple as possible.
Open the script `DCOPF.ipynb`. Enjoy!

# Problem formulation
Similar to the economic dispatch problem, DC OPF aims to minimize the total generation cost according to the polynomial characteristics of each generator:

$$ \min a_i \cdot (p_i^{gen})^2 + b_i \cdot p_i^{gen} + c_i $$

where $a,b,c$ are the cost coefficients, subject to:

```math
\begin{align}
p_i^{inj} &= \sum_{ik} p_{ik}^{line} - \sum_{ji} p_{ji}^{line}, &\forall i,j,k &\in \mathcal{N} \tag{1} \\
p_i^{inj} &= p_i^{gen} - p_i^{load}, &\forall i &\in \mathcal{N} \tag{2} \\
p_{ij}^{line} &= b_{ij}  (\theta_i - \theta_j), &\forall ij &\in \mathcal{B} \tag{3} \\
\theta_i &= 0, &i &\in \mathcal{N}^0 \tag{4}\\
\underline{p_i}^{gen} &\leq p_i^{gen} \leq \overline{p_i}^{gen}, &\forall i &\in \mathcal{G}  \tag{5} \\
-2\pi &\leq \theta_i \leq 2\pi, &\forall i &\in \mathcal{N} \tag{6} \\
\underline{p_{ij}}^{line} &\leq p_{ij}^{line} \leq \overline{p_{ij}}^{line}, &\forall ij &\in \mathcal{B} \tag{7}
\end{align}
```

```math
\begin{align}
  I_{k_1,\dots,k_n}
  &= \int_{C_n} x_1^{k_1}\cdots x_n^{k_n}\\
    &= \prod_i \frac{1 + (-1)^{k_i}}{k_i+1}
  =\begin{cases}
    0&\text{if any $k_i$ is odd}\\
    |C_n|&\text{if all $k_i=0$}\\
    I_{k_1,\dots,k_{i_0}-2,\dots,k_n} \times \frac{k_{i_0}-1}{k_{i_0}+1}&\text{if $k_{i_0} > 0$}
  \end{cases}
\end{align}
```

$\mathcal{N},\mathcal{B}$, and $\mathcal{G}$ are the sets of buses, lines, and generators, respectively. The bounds in eq. $(5)$ -- $(7)$ are stated implicitly in the variable bounds, not the constraint form. Well, you know the rest :)\
I tested on case9 and case39 and verified that the results were identical to the power flow modules like `pandapower` and `pypower`.\
Maybe, just maybe, the other cases work too. Or not.

"When will you publish an AC OPF optimization including renewables, energy storages, electric vehicle charging stations, and a flame dragon?"\
-"Bit too much, isn't it?."

***My brain was initially a potato. By learning more about things related to my research, it is now upgraded into a baked potato.***
