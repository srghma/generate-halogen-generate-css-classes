{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE PackageImports #-}

module Main where

-- TODO: use http://hackage.haskell.org/package/managed instead of turtle

-- TODO
-- dont use system-filepath (Filesystem.Path module, good lib, turtle is using it,         FilePath is just record)
-- dont use filepath        (System.FilePath module, bad lib,  directory-tree is using it, FilePath is just String)
-- use https://hackage.haskell.org/package/path-io-1.6.0/docs/Path-IO.html walkDirAccumRel

-- TODO
-- use https://hackage.haskell.org/package/recursion-schemes

-- import qualified Filesystem.Path.CurrentOS
import Options.Applicative
import "protolude" Protolude hiding (find)
import qualified "turtle" Turtle
import "turtle" Turtle ((</>))
import qualified "directory" System.Directory
import qualified "filepath" System.FilePath
import qualified "system-filepath" Filesystem.Path
import "base" Data.String (String)
import qualified "base" Data.String as String
import qualified "base" Data.List as List
import qualified Data.List.Index as List
import qualified "text" Data.Text as Text
import qualified Data.List.NonEmpty (NonEmpty)
import qualified Data.List.NonEmpty as NonEmpty
import qualified "cases" Cases
import Control.Concurrent.Async
import CssContentToTypes

data AppOptions = AppOptions
  { input :: Turtle.FilePath
  , output :: Turtle.FilePath
  , moduleName :: Text
  }

appOptionsParser :: Parser AppOptions
appOptionsParser = AppOptions
  <$> strOption ( long "input" <> metavar "FILEPATH")
  <*> strOption ( long "output" <> metavar "FILEPATH")
  <*> strOption ( long "module-name" <> metavar "FILEPATH")

appOptionsParserInfo :: ParserInfo AppOptions
appOptionsParserInfo = info (appOptionsParser <**> helper)
  ( fullDesc
  <> progDesc "Generate css"
  <> header "Generate css" )

appendIfNotAlreadySuffix :: Eq a => [a] -> [a] -> [a]
appendIfNotAlreadySuffix suffix target =
  if List.isSuffixOf suffix target
     then target
     else target ++ suffix

stripSuffix :: Eq a => [a] -> [a] -> [a]
stripSuffix suffix target =
  if List.isSuffixOf suffix target
     then List.reverse $ List.drop (List.length suffix) $ List.reverse target
     else target

-- make it end with /
makeValidDirectory :: Turtle.FilePath -> Turtle.FilePath
makeValidDirectory = Turtle.decodeString . appendIfNotAlreadySuffix "/" . Turtle.encodeString

main :: IO ()
main = Turtle.sh $ do
  appOptions <- execParser appOptionsParserInfo

  cssFileContent <- liftIO $ Turtle.readTextFile filePath

  let (classNames :: [Text]) = cssContentToTypes cssFileContent

  -- pathToModule <- liftIO $ fullPathToModuleName baseDir filePath

  -- -- liftIO $ putStrLn @Text $ "output " <> show classNames
  -- -- liftIO $ putStrLn @Text $ "pathToModule " <> show pathToModule

  -- let fileModuleName :: Text = NonEmpty.last (unModuleName pathToModule)

  -- let jsFilePath :: Turtle.FilePath = Turtle.directory filePath Turtle.</> Turtle.decodeString (toS fileModuleName) Turtle.<.> "js"
  -- let pursFilePath :: Turtle.FilePath = Turtle.directory filePath Turtle.</> Turtle.decodeString (toS fileModuleName) Turtle.<.> "purs"

  -- liftIO $ putStrLn $ "  writing " <> Turtle.encodeString jsFilePath
  -- liftIO $ putStrLn $ "  writing " <> Turtle.encodeString pursFilePath

  -- liftIO $ Turtle.writeTextFile jsFilePath ("exports.styles = require('./" <> fileModuleName <> ".module.css')")
  -- liftIO $ Turtle.writeTextFile pursFilePath
  --   ( let
  --       imports = Text.unlines $ List.imap (\(index) (className :: Text) -> (if index == 0 then "  { " else "  , ") <> className <> " :: ClassName") classNames
  --       styles =
  --         if List.length classNames == 0
  --             then "foreign import styles :: {}"
  --             else "foreign import styles ::\n" <> imports <> "  }"
  --     in Text.unlines
  --       [ "module Nextjs.Pages.Buttons.CSS (styles) where"
  --       , ""
  --       , "import Halogen.HTML (ClassName)"
  --       , ""
  --       , styles
  --       ]
  --   )
