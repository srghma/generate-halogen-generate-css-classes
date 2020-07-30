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
import "protolude" Protolude hiding (find, moduleName)
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

-- __ is a block, -- is now ____ and is a modifier
classNameToFunctionName :: Text -> Text
classNameToFunctionName = Text.replace "-" "_" . Text.replace "--" "____"

main :: IO ()
main = Turtle.sh $ do
  appOptions <- liftIO $ execParser appOptionsParserInfo

  cssFileContent <- liftIO $ Turtle.readTextFile (input appOptions)

  let (classNames :: [Text]) = cssContentToTypes cssFileContent

  liftIO $ Turtle.writeTextFile (output appOptions)
    ( let
        classesAndFunctions :: [(Text, Text)] = map (\x -> (x, classNameToFunctionName x)) classNames

        exports = classesAndFunctions & map snd & Text.intercalate ", "

        functions = classesAndFunctions
          & map (\(className, func) -> Text.unlines
                    [ func <> " :: ClassName"
                    , func <> " = ClassName \"" <> className <> "\""
                    ]
                )
          & Text.intercalate "\n"
      in Text.unlines
        [ "module " <> moduleName appOptions <> " (" <> exports <> ") where"
        , ""
        , "import Halogen.HTML (ClassName(..))"
        , ""
        , functions
        ]
    )
