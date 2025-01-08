import numpy as np
import matplotlib.pyplot as plt

# 采样率
Fs = 100 * 1_000_000  # 采样率100MHz
downsample_rate = 4  # 降采样倍数
bit_length = 8   # 16位有符号数
# 信号参数
N = 128 * downsample_rate * 2  # 采样点数
n = np.arange(1, N+1)
t = n / Fs
f1 = 4*1_000_000  # 信号频率1
f2 = 4*1_000_000  # 信号频率2

# 生成I路和Q路测试信号
s_i = np.cos(2 * np.pi * f1 * t)
s_q = np.sin(2 * np.pi * f2 * t)
data_before_fft_I = pow(2,6) * s_i  # I路放大100倍
data_before_fft_Q = pow(2,6) * s_q  # Q路放大100倍



# 保存为16位有符号二进制文件
with open(r'.\data_before_fft.txt', 'w') as fp:
    for i_val, q_val in zip(data_before_fft_I, data_before_fft_Q):
        # I路
        if i_val >= 0:
            temp_i = format(int(i_val), f'0{bit_length}b')
        else:
            temp_i = format(int(i_val) + 2**bit_length, f'0{bit_length}b')
        # Q路
        if q_val >= 0:
            temp_q = format(int(q_val), f'0{bit_length}b')
        else:
            temp_q = format(int(q_val) + 2**bit_length, f'0{bit_length}b')
        # 拼接I路和Q路
        fp.write(f"{temp_i}{temp_q}\r\n")



# 将I路和Q路组合成复数信号
signal = data_before_fft_I + 1j * data_before_fft_Q

# 执行FFT并移位
y = np.fft.fft(signal, N)
y_shifted = np.fft.fftshift(y)
y_magnitude = np.abs(y_shifted)

# 生成频率向量并移位
f = np.fft.fftfreq(N, d=1/Fs)
f_shifted = np.fft.fftshift(f)

# 绘制频谱
plt.plot(f_shifted, y_magnitude)
plt.xlabel('Frequency (Hz)')
plt.ylabel('Amplitude')
plt.title('FFT Result I路和Q路')
plt.show()