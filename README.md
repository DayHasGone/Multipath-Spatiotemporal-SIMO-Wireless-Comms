# Multipath-Spatiotemporal-SIMO-Wireless-Comms
The main objective is to simulate the communication process of the QPSK-DS-CMDA SIMO communication system in Matlab and to design a receiver that solves the problem of multipath and eliminates multiple accesses and interferences.

At the transmitting end, QPSK modulation and balanced golden sequences are used to implement direct sequence spread spectrum code division multiple access (DS-CDMA) technology to encode the data to be transmitted for different users. 

At the receiving end, the TOA and DOA of the destination signal are evaluated in the STAR-RAKE receiver using Spatiotemporal Manifold and the MUSIC algorithm, and the multipath signal weights are calculated and weighted to obtain the data that transmitted by the desired user.

Finally, the desired data are derived by despreading and demodulation. The final result: The system achieves a BER of 0.02% with an SNR of 0 dB.
