# Copyright (c) 2024 LFQ

import cmath, math
from jinja2 import Environment, FileSystemLoader

def make_twiddle_factor_file(N, tf_width, template_fn, output_fn):
    env = Environment(loader=FileSystemLoader('.'))
    template = env.get_template(template_fn)
    f_out = open(output_fn, 'w')
    Nlog2 = int(math.log(N, 2))
    tfs = []
    leftshift = pow(2, tf_width-2)
    for k in range(0, N//2):
        tf = {}
        tf['k'] = k
        v = cmath.exp(-k*2j*cmath.pi/N)
        if v.real > 0:
            tf['re_sign'] = ''
        else:
            tf['re_sign'] = '-'
            v = -v.real + (0+1j)*v.imag
        if v.imag > 0:
            tf['im_sign'] = ''
        else:
            tf['im_sign'] = '-'
            v = v.real - (0+1j)*v.imag
        tf['re'] = str(int(round(v.real * leftshift)))
        tf['im'] = str(int(round(v.imag * leftshift)))
        tfs.append(tf)
    f_out.write(template.render(tf_width=tf_width, tfs=tfs, Nlog2=Nlog2,N=N))    
    f_out.close()
    

if __name__ == '__main__':
    tf_width = 32
    N = 128
    
    output_fn = 'twiddlefactors_{0}.v'.format(N)
    make_twiddle_factor_file(N, tf_width,'twiddlefactors_N.v.t',output_fn)