//go:build e2e
// +build e2e

package resource_test

import (
	"os"
	"testing"

	"github.com/stretchr/testify/require"
	resource "github.com/telia-oss/github-pr-resource"
)

func TestListTeamMembers(t *testing.T) {
	source := resource.Source{
		Repository:  "cloudfoundry/community",
		AccessToken: os.Getenv("GITHUB_ACCESS_TOKEN"),
	}

	client, err := resource.NewGithubClient(&source)
	require.NoError(t, err)

	val, err := client.ListTeamMembers("wg-admin")
	require.NoError(t, err)

	require.Contains(t, val, "thelinuxfoundation")
}
