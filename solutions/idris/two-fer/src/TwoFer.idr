module TwoFer

export
twoFer : Maybe String -> String
twoFer (Just name) = "One for \{name}, one for me."
twoFer Nothing = twoFer (Just "you")
