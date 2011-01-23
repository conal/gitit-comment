{-# LANGUAGE PatternGuards #-}
{-# OPTIONS_GHC -Wall #-}
----------------------------------------------------------------------
-- |
-- Module      :  Network.Gitit.Plugin.Comment
-- Copyright   :  (c) Conal Elliott 2011
-- License     :  BSD3
-- 
-- Maintainer  :  conal@conal.net
-- Stability   :  experimental
-- 
-- Gitit plugin: remove comments like <!--# ... #-->
----------------------------------------------------------------------

module Network.Gitit.Plugin.Comment (plugin) where

import Data.List (isPrefixOf,isSuffixOf)

import Network.Gitit.Interface

plugin :: Plugin
plugin = PageTransform $ return {- . processWith fixBlock-} . processWith (concatMap fixInline)

-- , Plain [HtmlInline "<!--# ... #-->"]

fixInline :: Inline -> [Inline]
fixInline (HtmlInline s) | isPrefixOf "<!--#" s && isSuffixOf "#-->" s = []
fixInline x = [x]

-- fixBlock :: Block -> Block
-- fixBlock (CodeBlock attr@(_,classes,_) s)
--   | "haskell" `elem` classes = CodeBlock attr (translate s)
-- fixBlock x = x
