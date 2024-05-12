;; Tools
(package! nvm)
(package! org-roam-ui)
(package! elcord)
(package! lsp-tailwindcss :recipe (:host github :repo "merrickluo/lsp-tailwindcss"))
(package! leetcode)
(package! erc-hl-nicks)
(package! smudge)
(package! dirvish)
(package! org-caldav)
(package! catppuccin-theme)
(package! znc)

(package! pdf-tools :recipe
          (:host github
                 :repo "dalanicolai/pdf-tools"
                 :branch "pdf-roll"
                 :files ("lisp/*.el"
                         "README"
                         ("build" "Makefile")
                         ("build" "server")
                         (:exclude "lisp/tablist.el" "lisp/tablist-filter.el"))))

(package! image-roll :recipe
          (:host github
                 :repo "dalanicolai/image-roll.el"))
