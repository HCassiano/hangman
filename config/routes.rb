Rails.application.routes.draw do
  root "hangman#index"

  get 'hangman/', to: "hangman#index"
  get 'hangman/game/', to: "hangman#game"
  get 'hangman/letter/', to: "hangman#letter"
  get 'hangman/newgame/', to: "hangman#newgame"
  get 'hangman/report/', to: "hangman#report"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
