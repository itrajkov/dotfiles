(setq user-full-name "Ivche"
      user-mail-address "ivche@trajkov.mk")

;; (defun greedily-do-daemon-setup ()
;;   (require 'org)
;;   (when (require 'mu4e nil t)
;;     (setq mu4e-confirm-quit t)
;;     (setq +mu4e-lock-greedy t)
;;     (setq +mu4e-lock-relaxed t)
;;     (mu4e~start)))

;; (when (daemonp)
;;   (add-hook 'emacs-startup-hook #'greedily-do-daemon-setup)
;;   (add-hook! 'server-after-make-frame-hook
;;     (unless (string-match-p "\\*draft" (buffer-name)))))

(map! :leader
      :desc "Start ERC"
      "o i" #'my/erc-start-or-switch
      "i i" #'erc-switch-to-buffer)

;;(map! :map specific-mode-map :n "J" (cmd! (a-function) (b-function)))

(map! :map erc-mode-map :n "J" #'erc-join-channel)
(map! :map erc-mode-map :n "qq" #'my/erc-stop)
(map! :map erc-mode-map :n "c u" #'my/erc-count-users)

(setq auth-sources '("~/.authinfo.gpg"))

(setq initial-scratch-message ";; Happy Hacking!\n")

(setq doom-font (font-spec :family "SourceCodeVF" :size 18))

(setq display-line-numbers-type 'relative)
(setq truncate-lines nil)
(setq scroll-margin 9)

(setq doom-theme 'doom-solarized-dark-high-contrast)
(setq doom-modeline-height 4)
;; (set-frame-parameter (selected-frame) 'alpha '(96 . 96))
;; (add-to-list 'default-frame-alist '(alpha . (96 . 96)))

(require 'mu4e)
(require 'mu4e-contrib)
(require 'smtpmail)

(set-email-account! "icloud"
  '((user-mail-address . "trajkov.ivan@icloud.com")
    (user-full-name    . "Ivan Trajkov")
    (smtpmail-smtp-server . "smtp.mail.me.com")
    (smtpmail-smtp-service . 587)
    (smtpmail-stream-type . ssl)
    (smtpmail-smtp-user . "trajkov.ivan@icloud.com")
    (mu4e-drafts-folder  . "/icloud/Drafts")
    (mu4e-sent-folder  . "/icloud/Sent Mail")
    (mu4e-refile-folder  . "/icloud/All Mail")
    (mu4e-trash-folder  . "/icloud/Trash")
    (smtpmail-queue-dir .  "~/Mail/icloud/queue/cur")
    (mu4e-compose-signature . "---\nYours truly\nIvan.")
    (mu4e-maildir-shortcuts .
        (("/icloud/Inbox"             . ?i)
        ("/icloud/Sent Mail" . ?s)
        ("/icloud/Trash"     . ?t)
        ("/icloud/Drafts"    . ?d)
        ("/icloud/All Mail"  . ?a))))
  t)

(setq smtpmail-queue-mail t)  ;; start in queuing mode

(setq message-send-mail-function 'message-send-mail-with-sendmail)
(setq sendmail-program "/usr/bin/msmtp")
(setq message-sendmail-extra-arguments '("--read-envelope-from"))
(setq message-sendmail-f-is-evil 't)

(after! mu4e
  (setq mu4e-update-interval 60
        mu4e-get-mail-command "mbsync -a"
        mu4e-headers-auto-update t))

(setq mu4e-context-policy 'ask-if-none
      mu4e-compose-context-policy 'always-ask)

(setq mu4e-index-cleanup nil
      mu4e-index-lazy-check t)

(setq mu4e-alert-icon "/usr/share/icons/Papirus-Dark/16x16/mimetypes/mail.svg")

(setq mu4e-headers-fields
      '((:flags . 6)
        (:account-stripe . 2)
        (:from-or-to . 25)
        (:recipnum . 2)
        (:subject . 80)
        (:human-date . 8))
      +mu4e-min-header-frame-width 142
      mu4e-headers-date-format "%d/%m/%y"
      mu4e-headers-time-format "⧖ %H:%M"
      mu4e-headers-results-limit 1000
      mu4e-index-cleanup t)

;; (mu4e t)

(require 'erc-log)
(require 'erc-notify)
(require 'erc-spelling)
(require 'erc-autoaway)


(use-package erc
  :commands erc erc-tls
  :config
    (setq erc-autojoin-channels-alist '(("myanonamouse.net"
                                        "#am-members")
                                        ("libera.chat"
                                        "#spodeli")
                                        ("orpheus.network"
                                        "#disabled")))

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
    (setq erc-user-full-name "Ivche")

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

(after! company
    (setq default-tab-width 4)
    (setq company-minimum-prefix-length 3)
    (setq company-idle-delay 0.3))

(use-package! elcord
  :commands elcord-mode
  :config
  (setq elcord-use-major-mode-as-main-icon t))

(setq lsp-headerline-breadcrumb-enable t)

(after! leetcode
    (setq leetcode-prefer-language "cpp")
    (setq leetcode-save-solutions t)
    (setq leetcode-directory "~/dev/leetcode"))

(setq smudge-oauth2-client-secret "8fddb0ee81bf48db9f5bc3bea3d7e4cb")
(setq smudge-oauth2-client-id "a24417b7653d4974b19b7a07dcf1f7b2")
(setq smudge-transport 'connect)
(map! :prefix "C-s"
        :desc "Toggle Play/Pause" "p" #'smudge-controller-toggle-play
        :desc "Next Track" "n" #'smudge-controller-next-track
        :desc "Previous Track" "b" #'smudge-controller-previous-track
        :desc "Playlists" "P" #'smudge-my-playlists
        :desc "Track Search" "s" #'smudge-track-search)

(require 'org-caldav)

;; URL of the caldav server
(setq org-caldav-url "https://nextcloud.trajkov.mk/remote.php/dav/calendars/ivche")

;; calendar ID on server
(setq org-caldav-calendar-id "personal")

;; Org filename where new entries from calendar stored
(setq org-caldav-inbox (concat org-directory "/calendars/personal.org"))

;; Additional Org files to check for calendar events
(setq org-caldav-files nil)

;; Usually a good idea to set the timezone manually
(setq org-icalendar-timezone "Europe/Skopje")

(after! flycheck
  (add-hook 'python-mode-hook
            (lambda ()
              (setq lsp-pylsp-plugins-mccabe-enabled nil)
              (setq lsp-pylsp-plugins-flake8-enabled nil)
              (setq lsp-pylsp-plugins-pyflakes-enabled nil)
              (setq lsp-pylsp-plugins-pydocstyle-enabled nil)
              (setq flycheck-python-mypy-executable "mypy")
              (setq-local flycheck-checker 'python-mypy)
              (setq flycheck-checker-error-threshold 3000)
              )))


(after! dap
  (setq dap-python-debugger 'debugpy))

(setq org-directory "~/Documents/org")
(setq org-log-done 'time)

(setq rmh-elfeed-org-files (list (concat org-directory "/elfeed.org")))

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

(setq org-capture-templates `(
    ("p" "Protocol" entry (file+headline ,(concat org-directory "/inbox.org") "Captured Quotes")
     "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
    ("i" "Inbox" entry (file ,(concat org-directory "/inbox.org"))
     "* %? \nCaptured on: %T")
))

(setq org-roam-directory (concat org-directory "/roam"))

(setq org-roam-capture-templates
      '(("l" "literature" plain "%?"
         :if-new (file+head "literature/${slug}.org" "#+title: ${title}\n")
         :immediate-finish t
         :unnarrowed t)
        ("p" "permanent" plain "%?"
         :if-new (file+head "permanent/${title}.org" "#+title: ${title}\n")
         :immediate-finish t
         :unnarrowed t)
        ("a" "article" plain "%?"
         :if-new (file+head "article/${title}.org" "#+title: ${title}\n#+filetags: :article:\n")
         :immediate-finish t
         :unnarrowed t)))

(cl-defmethod org-roam-node-type ((node org-roam-node))
  "Return the TYPE of NODE."
  (condition-case nil
      (file-name-nondirectory
       (directory-file-name
        (file-name-directory
         (file-relative-name (org-roam-node-file node) org-roam-directory))))
    (error "")))

(setq org-roam-node-display-template
      (concat "${type:15} ${title:*} " (propertize "${tags:10}" 'face 'org-tag)))

(setq org-agenda-files (list (concat org-directory "/calendars/personal.org")))
