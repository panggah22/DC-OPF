# DC Optimal Power Flow using Gurobi (yep, finally.)

When I started learning power flow analysis in my undergrad, I stumbled upon the limitation of my potato brain to understand the basics of the power flow. 
Back then, there were no references to the optimization program of the economic dispatch or OPF specifically.
So, to help you guys who want to learn the basics of optimization, I present you my ~~not-finest~~ creation that I made in my spare time, sometimes when I am asleep too.\
This program uses Python 3.8 with the modules as follows:
`pandas`\
`matplotlib`\
`math`\
`networkx`\
`pypower`\
`gurobipy`

The network parameters are obtained from the `pypower` datasets, which are adjusted based on their format. For now, some cases throw an error (e.g., case24_rts, case57, case118, case300) due to double transmission lines between two buses that mess up the naming of the variable indices.\
To use `gurobipy`, Gurobi should be installed in the machine with a valid license (hey, student's license is very cool!). Please read its documentation to fully understand how the code works.\
Open the script `DCOPF.ipynb`. Enjoy!

# Problem formulation
Similar to the economic dispatch problem, DC OPF aims to minimize the total generation cost according to the polynomial characteristics of each generator:

$$ \min a_i \cdot (p_i^{gen})^2 + b_i \cdot p_i^{gen} + c_i $$

where $a,b,c$ are the cost coefficients, subject to:

$$
\begin{align}
p_i^{inj} &= \sum_{ji} p_{ji}^{line} - \sum_{ik} p_{ik}^{line}, &\forall i,j,k &\in \mathcal{N} \tag{1} \\
p_i^{inj} &= p_i^{gen} - p_i^{load}, &\forall i &\in \mathcal{N} \tag{2} \\
p_{ij}^{line} &= b_{ij}  (\theta_i - \theta_j), &\forall ij &\in \mathcal{B} \tag{3} \\
\theta_i &= 0, &i &\in \(slackbus\) \tag{4}\\
\underline{p_i}^{gen} &\leq p_i^{gen} \leq \overline{p_i}^{gen}, &\forall i &\in \mathcal{G}  \tag{5} \\
-2\pi &\leq \theta_i \leq 2\pi, &\forall i &\in \mathcal{N} \tag{6} \\
\underline{p_{ij}}^{line} &\leq p_{ij}^{line} \leq \overline{p_{ij}}^{line}, &\forall ij &\in \mathcal{B} \tag{7}
\end{align}
$$

$\mathcal{N},\mathcal{B}$, and $\mathcal{G}$ are the sets of buses, lines, and generators, respectively. Well, you know the rest :)
