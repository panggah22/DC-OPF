\ Model casestr
\ LP format - for model browsing. Use MPS format to capture full model detail.
Minimize
  500 P_Gen[1,0] + 120 P_Gen[2,0] + 100 P_Gen[3,0] + 1085 Constant + [
   2200 P_Gen[1,0] ^2 + 1700 P_Gen[2,0] ^2 + 2450 P_Gen[3,0] ^2 ] / 2 
Subject To
 P-Balance[1,0]: - P_Inj[1,0] + P_Line[1,4,0] = 0
 P-Balance[2,0]: - P_Inj[2,0] - P_Line[8,2,0] = 0
 P-Balance[3,0]: - P_Inj[3,0] + P_Line[3,6,0] = 0
 P-Balance[4,0]: - P_Inj[4,0] - P_Line[1,4,0] + P_Line[4,5,0]
   - P_Line[9,4,0] = 0
 P-Balance[5,0]: - P_Inj[5,0] - P_Line[4,5,0] + P_Line[5,6,0] = 0
 P-Balance[6,0]: - P_Inj[6,0] - P_Line[5,6,0] - P_Line[3,6,0]
   + P_Line[6,7,0] = 0
 P-Balance[7,0]: - P_Inj[7,0] - P_Line[6,7,0] + P_Line[7,8,0] = 0
 P-Balance[8,0]: - P_Inj[8,0] - P_Line[7,8,0] + P_Line[8,2,0]
   + P_Line[8,9,0] = 0
 P-Balance[9,0]: - P_Inj[9,0] - P_Line[8,9,0] + P_Line[9,4,0] = 0
 P-Injection[1,0]: - P_Gen[1,0] + P_Inj[1,0] = 0
 P-Injection[2,0]: - P_Gen[2,0] + P_Inj[2,0] = 0
 P-Injection[3,0]: - P_Gen[3,0] + P_Inj[3,0] = 0
 P-Injection[4,0]: P_Inj[4,0] = 0
 P-Injection[5,0]: P_Inj[5,0] = -0.9
 P-Injection[6,0]: P_Inj[6,0] = 0
 P-Injection[7,0]: P_Inj[7,0] = -1
 P-Injection[8,0]: P_Inj[8,0] = 0
 P-Injection[9,0]: P_Inj[9,0] = -1.25
 Angle-Diff[1,4,0]: - 17.36111111111111 Theta[1,0]
   + 17.36111111111111 Theta[4,0] + P_Line[1,4,0] = 0
 Angle-Diff[4,5,0]: - 10.8695652173913 Theta[4,0]
   + 10.8695652173913 Theta[5,0] + P_Line[4,5,0] = 0
 Angle-Diff[5,6,0]: - 5.88235294117647 Theta[5,0]
   + 5.88235294117647 Theta[6,0] + P_Line[5,6,0] = 0
 Angle-Diff[3,6,0]: - 17.06484641638225 Theta[3,0]
   + 17.06484641638225 Theta[6,0] + P_Line[3,6,0] = 0
 Angle-Diff[6,7,0]: - 9.920634920634921 Theta[6,0]
   + 9.920634920634921 Theta[7,0] + P_Line[6,7,0] = 0
 Angle-Diff[7,8,0]: - 13.88888888888889 Theta[7,0]
   + 13.88888888888889 Theta[8,0] + P_Line[7,8,0] = 0
 Angle-Diff[8,2,0]: 16 Theta[2,0] - 16 Theta[8,0] + P_Line[8,2,0] = 0
 Angle-Diff[8,9,0]: - 6.211180124223603 Theta[8,0]
   + 6.211180124223603 Theta[9,0] + P_Line[8,9,0] = 0
 Angle-Diff[9,4,0]: 11.76470588235294 Theta[4,0]
   - 11.76470588235294 Theta[9,0] + P_Line[9,4,0] = 0
 Slack-Angle[1,0]: Theta[1,0] = 0
Bounds
 0.1 <= P_Gen[1,0] <= 2.5
 0.1 <= P_Gen[2,0] <= 3
 0.1 <= P_Gen[3,0] <= 2.7
 P_Inj[1,0] free
 P_Inj[2,0] free
 P_Inj[3,0] free
 P_Inj[4,0] free
 P_Inj[5,0] free
 P_Inj[6,0] free
 P_Inj[7,0] free
 P_Inj[8,0] free
 P_Inj[9,0] free
 -3.141592653589793 <= Theta[1,0] <= 3.141592653589793
 -3.141592653589793 <= Theta[2,0] <= 3.141592653589793
 -3.141592653589793 <= Theta[3,0] <= 3.141592653589793
 -3.141592653589793 <= Theta[4,0] <= 3.141592653589793
 -3.141592653589793 <= Theta[5,0] <= 3.141592653589793
 -3.141592653589793 <= Theta[6,0] <= 3.141592653589793
 -3.141592653589793 <= Theta[7,0] <= 3.141592653589793
 -3.141592653589793 <= Theta[8,0] <= 3.141592653589793
 -3.141592653589793 <= Theta[9,0] <= 3.141592653589793
 -2.5 <= P_Line[1,4,0] <= 2.5
 -2.5 <= P_Line[4,5,0] <= 2.5
 -1.5 <= P_Line[5,6,0] <= 1.5
 -3 <= P_Line[3,6,0] <= 3
 -1.5 <= P_Line[6,7,0] <= 1.5
 -2.5 <= P_Line[7,8,0] <= 2.5
 -2.5 <= P_Line[8,2,0] <= 2.5
 -2.5 <= P_Line[8,9,0] <= 2.5
 -2.5 <= P_Line[9,4,0] <= 2.5
 Constant = 1
End
