let vimclojure#WantNailgun=1
let vimclojure#UseErrorBuffer=0
let g:vimclojure#ParenRainbow=1

command! -nargs=1 ClojureEval call myclojure#evalCommand(<q-args>)