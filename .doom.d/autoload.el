;;;###autoload
(defun my/evil-scroll-down-and-center ()
  (interactive)
  (evil-scroll-down 0)
  (recenter nil))

;;;###autoload
(defun my/evil-scroll-up-and-center ()
  (interactive)
  (evil-scroll-up 0)
  (recenter nil))
