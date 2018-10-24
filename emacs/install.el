(package-initialize)
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'load-path "~/.emacs.d/lisp/")
(add-to-list 'load-path "~/.emacs.d/ext_pkgs/")

(mapc
 (lambda (package)
   (unless (package-installed-p package)
     (progn (message "installing %s" package)
            (package-refresh-contents)
            (package-install package))))
 '(
   zenburn-theme
   color-theme-sanityinc-tomorrow
   ycmd                 
   flycheck             
   flycheck-ycmd
   eldoc                
   opencl-mode          
   modern-cpp-font-lock 
   flx-ido              
   rtags                
   projectile
   projectile-ripgrep
   clang-format         
   cmake-mode           
   js2-mode             
   js2-refactor
   xref-js2
   company-tern
   tern
   js-format
   ag
   magit                
   autopair
   company-ycmd
   rjsx-mode
   skewer-mode
   ivy
   ivy-rtags
   ivy-xref
   xcode-project
   swift-mode
   rainbow-identifiers
   add-node-modules-path
   web-mode
   company-web
   company-statistics
   exec-path-from-shell
   fzf
   markdown-mode))

(load "flycheck-swift3")
