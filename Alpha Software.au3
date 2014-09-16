#include <variables.au3>
#include <functions.au3>
InitializeComponent()

Func main()
	Switch location()
		Case "loading"
			Sleep(500)
		Case "wp"
			Send("{ESC}")
			Sleep(250)
		Case "game"
			If $followMode Then
				If friendly() Then
					If nearfriendly() Then
						If items() Then
							Sleep(1000)
						Else
							If targetscan() Then
							Else
								findFriend(50)
							EndIf
						EndIf
					Else
						findFriend(200)
					EndIf
				Else
					If findinstance() Then
					Else
						lost()
					EndIf

				EndIf
			Else
			EndIf
		Case "dead"
			MouseClick("left", 427, 207, 1)
		Case Else
			button("login")
			button("play")
			Return Null
	EndSwitch
EndFunc   ;==>main
