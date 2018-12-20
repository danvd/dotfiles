;;; package --- Summary
;;; Commentary:
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (package-initialize)
;;; Code:
;;; Commentary: Loads elisp file from .emacs.d
(defun load-user-file (file) (interactive "f")
  "Load a file in current user's configuration directory"
  ;; (load-file (expand-file-name file user-init-dir)))
  (load-file (expand-file-name file "~/.emacs.d")))

(load-user-file  "install.el")

(eval-after-load 'js-mode
  '(add-hook 'js-mode-hook #'add-node-modules-path))

(when (memq window-system '(mac ns))
  (setenv "SHELL" "/usr/local/bin/bash")
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-envs
   '("PATH")))

;; (load-theme 'zenburn t)
(load-theme 'sanityinc-tomorrow-night t)
(desktop-save-mode 1)

(show-paren-mode 1)
(global-hl-line-mode +1)
(set-face-background 'hl-line "#333333")

(require 'rtags)
;; (rtags-start-process-unless-running)
(setq rtags-display-result-backend 'ivy)

(setq create-lockfiles nil)

 (setq backup-directory-alist
          `(("." . ,(concat user-emacs-directory "backups"))))

(require 'company)

(add-hook 'after-init-hook 'global-company-mode)
(setq company-dabbrev-downcase 0)
(setq company-idle-delay 0)

(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;; (add-to-list 'auto-mode-alist '("\\.jsx\\'" . js2-mode))

;; (require 'rjsx-mode)

;; (add-hook 'js2-mode-hook 'skewer-mode)
;; (add-hook 'css-mode-hook 'skewer-css-mode)
;; (add-hook 'html-mode-hook 'skewer-html-mode)

;; Better imenu
(add-hook 'js2-mode-hook #'js2-imenu-extras-mode)

(require 'js2-refactor)

(add-hook 'js2-mode-hook #'js2-refactor-mode)
(js2r-add-keybindings-with-prefix "C-c C-r")
(define-key js2-mode-map (kbd "C-k") #'js2r-kill)

;; (require 'xref-js2)

;; js-mode (which js2 is based on) binds "M-." which conflicts with xref, so
;; unbind it.
;; (define-key js-mode-map (kbd "M-.") nil)

(add-hook 'js2-mode-hook (lambda ()
  (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t)))

(require 'company-tern)

(add-to-list 'company-backends 'company-tern)
(add-hook 'js2-mode-hook (lambda ()
                           (tern-mode)
                           (company-mode)))



;; Disable completion keybindings, as we use xref-js2 instead
;;(define-key tern-mode-keymap (kbd "M-.") nil)
;;(define-key tern-mode-keymap (kbd "M-,") nil)

;; then require the package in your config
(require 'js-format)
;; using "standard" as js formatter
 (add-hook 'js2-mode-hook
            (lambda()
              (js-format-setup "esfmt")))

;; using "jsbeautify-css" as css formatter
 (add-hook 'css-mode-hook
            (lambda()
              (js-format-setup "jsb-css")))

(define-key js2-mode-map (kbd "C-c i") 'js-format-region)
(define-key js2-mode-map (kbd "C-c u") 'js-format-buffer)

;; web mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(setq web-mode-enable-auto-pairing t)
(setq web-mode-enable-css-colorization t)
(setq web-mode-enable-current-element-highlight t)
(setq web-mode-markup-indent-offset 4)
(setq web-mode-css-indent-offset 4)
(setq web-mode-code-indent-offset 4)
(setq web-mode-style-padding 1)
(setq web-mode-script-padding 1)

(require 'company-web-html)

(defun my-web-mode-hook ()
  "Hook for `web-mode'."
    (set (make-local-variable 'company-backends)
         '(company-tern company-web-html)))

(add-hook 'web-mode-hook 'my-web-mode-hook)

;; Enable JavaScript completion between <script>...</script> etc.
(advice-add 'company-tern :before
            #'(lambda (&rest _)
                (if (equal major-mode 'web-mode)
                    (let ((web-mode-cur-language
                          (web-mode-language-at-pos)))
                      (if (or (string= web-mode-cur-language "javascript")
                              (string= web-mode-cur-language "jsx"))
                          (unless tern-mode (tern-mode))
                        (if tern-mode (tern-mode -1)))))))

;; manual autocomplete
(global-set-key (kbd "M-SPC") 'company-complete)


(require 'linum)
(add-hook 'prog-mode-hook 'linum-mode)
(setq linum-format "%4d \u2502 ")

(add-to-list 'auto-mode-alist '("\\.mm\\'" . objc-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . objc-mode))
(require 'opencl-mode)
(add-to-list 'auto-mode-alist '("\\.cl\\'" . opencl-mode))
(require 'modern-cpp-font-lock)
(modern-c++-font-lock-global-mode t)

(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

(rtags-enable-standard-keybindings)

(define-key c-mode-base-map (kbd "M-.") 'rtags-find-symbol-at-point)
(define-key c-mode-base-map (kbd "M-,") 'rtags-location-stack-back)

(add-hook 'c-mode-common-hook 'rainbow-identifiers-mode)

(require 'ycmd)
;; (add-hook 'after-init-hook #'global-ycmd-mode)
(add-hook 'c-mode-common-hook 'ycmd-mode)

(set-variable 'ycmd-server-command `("python" ,(file-truename "~/Downloads/ycmd/ycmd/")))
(set-variable 'ycmd-extra-conf-whitelist '("~/Projects/*"))
(set-variable 'ycmd-global-config "~/.emacs.d/.ycm_extra_conf.py")
(require 'company-ycmd)
(company-ycmd-setup)
(require 'ycmd-eldoc)
(add-hook 'ycmd-mode-hook 'ycmd-eldoc-setup)

(flycheck-ycmd-setup)

;; (setq rtags-autostart-diagnostics t)
;; (rtags-diagnostics)
;; (setq rtags-completions-enabled t)
;; (push 'company-rtags company-backends)
;; (define-key c-mode-base-map (kbd "<C-tab>") (function company-complete))

(global-flycheck-mode)

'(flycheck-highlighting-mode (quote lines))
(setq flycheck-indication-mode nil)

(require 'clang-format)
(define-key c-mode-base-map (kbd "C-c i") 'clang-format-region)
(define-key c-mode-base-map (kbd "C-c u") 'clang-format-buffer)

(setq clang-format-style-option "file")

(add-hook 'c-mode-common-hook
          (lambda () (add-hook 'before-save-hook 'clang-format-buffer nil 'local)))


(defconst user-init-dir
  (cond ((boundp 'user-emacs-directory)
         user-emacs-directory)
        ((boundp 'user-init-directory)
         user-init-directory)
        (t "~/.emacs.d/")))


(defun load-user-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (load-file (expand-file-name file user-init-dir)))

(load-user-file "indent.el")

(global-set-key (kbd "C-x C-o") 'ff-find-other-file)

(require 'autopair)
(autopair-global-mode) ;; enable autopair in all buffers

(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)

(global-set-key (kbd "M-v") '(lambda nil (interactive) (condition-case nil
                                                             (scroll-down) (beginning-of-buffer (goto-char (point-min))))))
(global-set-key (kbd "C-v") '(lambda nil (interactive) (condition-case nil
                                                             (scroll-up) (end-of-buffer (goto-char (point-max))))))
(global-set-key (kbd "<prior>") '(lambda nil (interactive) (condition-case nil
                                                             (scroll-down) (beginning-of-buffer (goto-char (point-min))))))
(global-set-key (kbd "<next>") '(lambda nil (interactive) (condition-case nil
                                                             (scroll-up) (end-of-buffer (goto-char (point-max))))))
(global-set-key (kbd "C-c o") 'fzf)
(global-set-key (kbd "C-c p") 'fzf-git)

(defun on-after-init ()
  (unless (display-graphic-p (selected-frame))
    (set-face-background 'default "unspecified-bg" (selected-frame))))

(add-hook 'window-setup-hook 'on-after-init)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "e11569fd7e31321a33358ee4b232c2d3cf05caccd90f896e1df6cab228191109" default)))
 '(package-selected-packages
   (quote
    (prompt-text promise eldoc-eval dtrt-indent rainbow-identifiers rjsx-mode company-tern tern ac-js2 xref-js2 js2-refactor skewer-mode js2-mode ycm modern-cpp-font-lock opencl-mode clang-format flx-ido ## klere-theme))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
