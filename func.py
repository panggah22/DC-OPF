import networkx as nx
import matplotlib.pyplot as plt

# Function for obtaining reactance
def perB(line_df,m,n):
    if (m,n) not in line_df.index:
        temp = m
        m = n
        n = temp
    return 1/(line_df.loc[(m,n),'x'])

# Obtain the values of gurobi variables
def var_values(y,mult=1):
    z = []
    for v in y.values():
        z.append(v.X*mult)
    return z

def lineflow_plot(line, Pline):
    plt.figure(figsize=[10,10])
    plt.title('Power Flow on Lines')

    # Dummy positioning
    F = nx.Graph()
    F.add_edges_from(line.index)
    pos = nx.spring_layout(F, iterations=100, seed=69420)

    # Directed flows
    G = nx.DiGraph()
    k = 0
    for i in line.index:
        if Pline[k] > 0:
            G.add_edge(i[0],i[1],weight=abs(round(Pline[k],2)))
        else:
            G.add_edge(i[1],i[0],weight=abs(round(Pline[k],2)))
        k = k+1

    nx.draw_networkx(G,pos, with_labels=True, width=3, arrowstyle='-|>')
    edge_labels = nx.get_edge_attributes(G, "weight")
    nx.draw_networkx_edge_labels(G, pos, edge_labels, font_size=8)