package main

import (
	"fmt"
	"os"
	"os/exec"
	"strings"
)

func main() {
	gitCmd := "git"
	var mkdocsOutput []byte

	latestCommitOutput, err := exec.Command(gitCmd, "rev-parse", "HEAD").Output()

	if err != nil {
		fmt.Fprintln(os.Stderr, "There was an error running git rev-parse command: ", err)
		os.Exit(1)
	}

	docsFolderCommitOutput, err := exec.Command(gitCmd, "log", "-1", "--format=format:%H", "--full-diff", "docs").Output()

	if err != nil {
		fmt.Fprintln(os.Stderr, "There was an error running git log command: ", err)
		os.Exit(1)
	}

	if strings.TrimRight(string(latestCommitOutput), "\n") == strings.TrimRight(string(docsFolderCommitOutput), "\n") {
		// mkdocsOutput, err = exec.Command("pwd").Output()
		mkdocsOutput, err = exec.Command("mkdocs", "gh-deploy").Output()
		fmt.Printf("%s", string(mkdocsOutput))
	}

	if err != nil {
		fmt.Fprintln(os.Stderr, "There was an error running 'mkdocs gh-dpeloy': ", err)
	}
}
