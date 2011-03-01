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
-- Gitit plugin: remove comments like <!--[ ... ]-->
----------------------------------------------------------------------

module Network.Gitit.Plugin.Comment (plugin) where

import Data.List (isPrefixOf,isSuffixOf)

import Network.Gitit.Interface

plugin :: Plugin
plugin = PageTransform $ return . bottomUp (concatMap fixBlock) . bottomUp (concatMap fixInline)

fixInline :: Inline -> [Inline]
fixInline (RawInline "html" s) | isPrefixOf "<!--[" s && isSuffixOf "]-->" s = []
fixInline x = [x]

-- After emptying some html inlines, we might have empty blocks.
-- I haven't tested this plugin enough to see what happens.

fixBlock :: Block -> [Block]
fixBlock (Plain []) = []
fixBlock x = [x]
