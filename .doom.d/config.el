(setq user-full-name "Ivan Trajkov"
      user-mail-address "itrajkov999@gmail.com")

(defun greedily-do-daemon-setup ()
  (require 'org)
  (when (require 'mu4e nil t)
    (setq mu4e-confirm-quit t)
    (setq +mu4e-lock-greedy t)
    (setq +mu4e-lock-relaxed t)
    (mu4e~start)))

(when (daemonp)
  (add-hook 'emacs-startup-hook #'greedily-do-daemon-setup)
  (add-hook! 'server-after-make-frame-hook
    (unless (string-match-p "\\*draft" (buffer-name))
      (switch-to-buffer +doom-dashboard-name))))

(setq auth-sources '("~/.authinfo.gpg"))

(map! :map evil-motion-state-map "C-u" #'my/evil-scroll-up-and-center)
(map! :map evil-motion-state-map "C-d" #'my/evil-scroll-down-and-center)
(map! :map evil-normal-state-map "C-x" #'evil-numbers/dec-at-pt-incremental)
(map! :map evil-normal-state-map "C-a" #'evil-numbers/inc-at-pt-incremental)
(map! :map evil-normal-state-map "C--" #'doom/decrease-font-size)
(map! :map evil-normal-state-map "C-+" #'doom/increase-font-size)

(map! :leader
      :desc "Start ERC"
      "o i" #'my/erc-start-or-switch
      "i i" #'erc-switch-to-buffer)

;;(map! :map specific-mode-map :n "J" (cmd! (a-function) (b-function)))

(map! :map erc-mode-map :n "J" #'erc-join-channel)
(map! :map erc-mode-map :n "qq" #'my/erc-stop)
(map! :map erc-mode-map :n "c u" #'my/erc-count-users)

(setq doom-font (font-spec :family "Fira Code Nerd Font" :size 18))

(setq display-line-numbers-type 'relative)
(setq truncate-lines nil)
(setq scroll-margin 9)

(setq doom-theme 'doom-monokai-pro)
(set-frame-parameter (selected-frame) 'alpha '(93 . 93))
(add-to-list 'default-frame-alist '(alpha . (93 . 93)))

(set-email-account! "ivchepro@gmail.com"
  '((user-mail-address . "ivchepro@gmail.com")
    (user-full-name    . "Беден Буџи")
    (smtpmail-smtp-server . "smtp.gmail.com")
    (smtpmail-smtp-service . 465)
    (smtpmail-stream-type . ssl)
    (smtpmail-smtp-user . "ivchepro@gmail.com")
    (mu4e-drafts-folder  . "/ivchepro/[Gmail]/Drafts")
    (mu4e-sent-folder  . "/ivchepro/[Gmail]/Sent Mail")
    (mu4e-refile-folder  . "/ivchepro/[Gmail]/All Mail")
    (mu4e-trash-folder  . "/ivchepro/[Gmail]/Trash")
    (smtpmail-queue-dir .  "~/Mail/ivchepro/queue/cur")
    (mu4e-compose-signature . "---\nYours truly\nIvche.")
    (mu4e-maildir-shortcuts .
        (("/ivchepro/Inbox"             . ?i)
        ("/ivchepro/[Gmail]/Sent Mail" . ?s)
        ("/ivchepro/[Gmail]/Trash"     . ?t)
        ("/ivchepro/[Gmail]/Drafts"    . ?d)
        ("/ivchepro/[Gmail]/All Mail"  . ?a))))
  t)

(set-email-account! "itrajkov999@gmail.com"
  '((user-mail-address . "itrajkov999@gmail.com")
    (user-full-name    . "Ivan Trajkov")
    (smtpmail-smtp-server . "smtp.gmail.com")
    (smtpmail-smtp-service . 465)
    (smtpmail-stream-type . ssl)
    (smtpmail-smtp-user . "itrajkov999@gmail.com")
    (mu4e-drafts-folder  . "/itrajkov999/[Gmail]/Drafts")
    (mu4e-sent-folder  . "/itrajkov999/[Gmail]/Sent Mail")
    (mu4e-refile-folder  . "/itrajkov999/[Gmail]/All Mail")
    (mu4e-trash-folder  . "/itrajkov999/[Gmail]/Trash")
    (smtpmail-queue-dir .  "~/Mail/itrajkov999/queue/cur")
    (mu4e-compose-signature . "---\nYours truly\nIvan.")
    (mu4e-maildir-shortcuts .
        (("/itrajkov999/Inbox"             . ?i)
        ("/itrajkov999/[Gmail]/Sent Mail" . ?s)
        ("/itrajkov999/[Gmail]/Trash"     . ?t)
        ("/itrajkov999/[Gmail]/Drafts"    . ?d)
        ("/itrajkov999/[Gmail]/All Mail"  . ?a))))
  t)

(setq mu4e-context-policy 'ask-if-none
      mu4e-compose-context-policy 'always-ask)

;; don't need to run cleanup after indexing for gmail
(setq mu4e-index-cleanup nil
      ;; because gmail uses labels as folders we can use lazy check since
      ;; messages don't really "move"
      mu4e-index-lazy-check t)

(setq mu4e-alert-icon "/usr/share/icons/Papirus/64x64/apps/evolution.svg")

(setq mu4e-headers-fields
      '((:flags . 6)
        (:account-stripe . 2)
        (:from-or-to . 25)
        (:folder . 10)
        (:recipnum . 2)
        (:subject . 80)
        (:human-date . 8))
      +mu4e-min-header-frame-width 142
      mu4e-headers-date-format "%d/%m/%y"
      mu4e-headers-time-format "⧖ %H:%M"
      mu4e-headers-results-limit 1000
      mu4e-index-cleanup t)

(require 'erc-log)
(require 'erc-notify)
(require 'erc-nick-notify)
(require 'erc-spelling)
(require 'erc-autoaway)


(use-package erc
  :commands erc erc-tls
  :config
    ;; Join the a couple of interesting channels whenever connecting to Freenode.
    (setq erc-autojoin-channels-alist '(("myanonamouse.net"
                                        "#am-members")
                                        ("libera.chat"
                                        "#spodeli")))

    (add-hook 'window-configuration-change-hook
        '(lambda ()
            (setq erc-fill-column (- (window-width) 2))))

    ;; Interpret mIRC-style color commands in IRC chats
    (setq erc-interpret-mirc-color t)

    ;; The following are commented out by default, but users of other
    ;; non-Emacs IRC clients might find them useful.
    ;; Kill buffers for channels after /part
    (setq erc-kill-buffer-on-part t)
    ;; Kill buffers for private queries after quitting the server
    (setq erc-kill-queries-on-quit t)
    ;; Kill buffers for server messages after quitting the server
    (setq erc-kill-server-buffer-on-quit t)

    ;; open query buffers in the current window
    (setq erc-query-display 'buffer)

    (setq erc-track-shorten-function nil)
    ;; exclude boring stuff from tracking
    (erc-track-mode t)
    (setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
                                    "324" "329" "332" "333" "353" "477"))

    ;; truncate long irc buffers
    (erc-truncate-mode +1)

    ;; reconnecting
    (setq erc-server-reconnect-attempts 5)
    (setq erc-server-reconnect-timeout 30)

    ;; share my real name
    (setq erc-user-full-name "Ivan Trajkov")

    ;; enable spell checking
    (erc-spelling-mode 1)

    (defvar erc-notify-timeout 10
    "Number of seconds that must elapse between notifications from
    the same person.")

    (defun my/erc-notify (nickname message)
    "Displays a notification message for ERC."
    (let* ((channel (buffer-name))
            (nick (erc-hl-nicks-trim-irc-nick nickname))
            (title (if (string-match-p (concat "^" nickname) channel)
                        nick
                    (concat nick " (" channel ")")))
            (msg (s-trim (s-collapse-whitespace message))))
        (alert (concat nick ": " msg) :title title)))

    ;; autoaway setup
    (setq erc-auto-discard-away t)
    (setq erc-autoaway-idle-seconds 600)
    (setq erc-autoaway-use-emacs-idle t)
    (setq erc-prompt-for-nickserv-password nil)

    ;; utf-8 always and forever
    (setq erc-server-coding-system '(utf-8 . utf-8))

    (defun my/erc-start-or-switch ()
    "Connects to ERC, or switch to last active buffer."
    (interactive)
    (if (get-buffer "irc.libera.chat:6697")
        (erc-track-switch-buffer 1)
        (when (y-or-n-p "Start ERC? ")
        (erc-tls :server "irc.libera.chat" :port 6697 :nick "ivche")
        (erc-tls :server "irc.myanonamouse.net" :port 6697 :nick "Ivche1337")
        )))

    (defun my/erc-count-users ()
    "Displays the number of users connected on the current channel."
    (interactive)
    (if (get-buffer "irc.libera.chat:6697")
        (let ((channel (erc-default-target)))
            (if (and channel (erc-channel-p channel))
                (message "%d users are online on %s"
                        (hash-table-count erc-channel-users)
                        channel)
            (user-error "The current buffer is not a channel")))
        (user-error "You must first start ERC")))

    (defun filter-server-buffers ()
    (delq nil
            (mapcar
            (lambda (x) (and (erc-server-buffer-p x) x))
            (buffer-list))))

    (defun my/erc-stop ()
    "Disconnects from all irc servers"
    (interactive)
    (dolist (buffer (filter-server-buffers))
        (message "Server buffer: %s" (buffer-name buffer))
        (with-current-buffer buffer
        (erc-quit-server "cya nerds! - sent from ERC"))))
)

(use-package erc-hl-nicks
  :after erc)

(setq default-tab-width 4)
(setq company-minimum-prefix-length 2)
(setq company-idle-delay 0)

(setq org-directory "~/Dropbox/org")

(add-hook 'org-mode-hook #'+org-pretty-mode)

(custom-set-faces!
  '(outline-1 :weight extra-bold :height 1.25)
  '(outline-2 :weight bold :height 1.15)
  '(outline-3 :weight bold :height 1.12)
  '(outline-4 :weight semi-bold :height 1.09)
  '(outline-5 :weight semi-bold :height 1.06)
  '(outline-6 :weight semi-bold :height 1.03)
  '(outline-8 :weight semi-bold)
  '(outline-9 :weight semi-bold))

(custom-set-faces!
  '(org-document-title :height 1.2))

(setq org-agenda-deadline-faces
      '((1.001 . error)
        (1.0 . org-warning)
        (0.5 . org-upcoming-deadline)
        (0.0 . org-upcoming-distant-deadline)))

(setq org-fontify-quote-and-verse-blocks t)

(add-to-list 'org-modules 'org-habit t)

(setq org-agenda-files '("~/Dropbox/org/ivches-system/Personal"))
(setq org-agenda-search-headline-for-time nil)
(setq org-agenda-custom-commands
      '(("h" "Daily habits"
         ((agenda ""))
         ((org-agenda-show-log t)
          (org-agenda-ndays 11)
          (org-agenda-log-mode-items '(state))
          (org-agenda-skip-function '(org-agenda-skip-entry-if 'notregexp ":DAILY:"))))
        ))

(use-package! tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))
