import pandas as pd
import pypower.api

class load_system:
    def __init__(self, case):
        self.case = case
        self.net = getattr(pypower.api, case)()
        self.MVAbase = self.net['baseMVA']
        self.bus, self.line, self.gen = self._load()

    def _load(self):
        bus = self._load_bus_data()
        line = self._load_line_data()
        gen = self._load_gen_data()
        return bus, line, gen

    def _load_bus_data(self):
        bus_df = pd.DataFrame.from_dict(self.net['bus'])
        bus_df.columns = ['bus', 'type', 'Pd', 'Qd', 'Gs', 'Bs', 'area', 'Vm', 'Va', 'baseKV', 'zone', 'Vmax', 'Vmin']
        bus_df = bus_df.astype({'bus': 'int', 'type': 'int'})
        bus_df.set_index('bus', inplace=True)
        bus_df['Pd'] /= self.MVAbase
        bus_df['Qd'] /= self.MVAbase
        return bus_df

    def _load_line_data(self):
        line_df = pd.DataFrame.from_dict(self.net['branch'])
        line_df.columns = ['fbus', 'tbus', 'r', 'x', 'b', 'rateA', 'rateB', 'rateC', 'ratio', 'angle', 'status', 'angmin', 'angmax']
        line_df = line_df.astype({'fbus': 'int', 'tbus': 'int'})
        line_df.set_index(['fbus', 'tbus'], inplace=True)
        line_df['rateA'] /= self.MVAbase
        return line_df

    def _load_gen_data(self):
        gen_df = pd.DataFrame.from_dict(self.net['gen'])
        gen_df.columns = ['bus', 'Pg', 'Qg', 'Qmax', 'Qmin', 'Vg', 'mBase', 'status', 'Pmax', 'Pmin', 'Pc1', 'Pc2', 'Qc1min', 'Qc1max', 'Qc2min', 'Qc2max', 'ramp_agc', 'ramp_10', 'ramp_30', 'ramp_q', 'apf']
        gen_df = gen_df.astype({'bus': 'int', 'status': 'int'})
        
        gencost_df = pd.DataFrame.from_dict(self.net['gencost'])
        gencost_df.columns = ['x1', 'x2', 'x3', 'x4', 'a', 'b', 'c']
        
        gens_df = pd.concat([gen_df, gencost_df], axis=1)
        gens_df = gens_df.dropna(axis=0) # Clearing NaN entries, intended for case30Q which has more gencost than the number of generators
        gens_df.set_index('bus', inplace=True)
        gens_df['Pmax'] /= self.MVAbase
        gens_df['Pmin'] /= self.MVAbase
        return gens_df