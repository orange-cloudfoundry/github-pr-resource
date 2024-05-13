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

func Test_cleanBotUserName(t *testing.T) {
	type args struct {
		username string
	}
	tests := []struct {
		name string
		args args
		want string
	}{
		{
			name: "Main Test Case",
			args: args{
				username: "infratest[bot]",
			},
			want: "infratest",
		},
		{
			name: "Without suffix bot",
			args: args{
				username: "infratest",
			},
			want: "infratest",
		},
		{
			name: "Bot only",
			args: args{
				username: "[bot]",
			},
			want: "",
		},
		{
			name: "Bot at start",
			args: args{
				username: "[bot]infratest",
			},
			want: "[bot]infratest",
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := cleanBotUserName(tt.args.username); got != tt.want {
				t.Errorf("cleanBotUserName() = %v, want %v", got, tt.want)
			}
		})
	}
}
