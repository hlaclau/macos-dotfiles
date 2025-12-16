#!/usr/bin/env bash
set -euo pipefail

# Color variables
mauve="#cba6f7"
lavender="#b4befe"
pink="#f5c2e7"
overlay="#6c7086"
text="#cdd6f4"

# Title Banner
gum style --foreground "$mauve" --bold "🌸 Pull Request Creator"

# Get branches
branches=$(git branch --format="%(refname:short)")
current_branch=$(git rev-parse --abbrev-ref HEAD)

# Source branch (preselect current)
source_branch=$(echo "$branches" | gum choose --header "🌿 Select source branch" --selected "$current_branch")

# Target branch
target_branch=$(echo "$branches" | gum choose --header "🎯 Select target branch (usually main or develop)")

# Title & Description
title=$(gum input --placeholder "✨ Pull request title")
gum style --foreground "$lavender" "📝 Write description (Ctrl+D to finish):"
description=$(gum write --placeholder "Add detailed context, changes made...")

# Confirm
gum confirm "🚀 Create PR from '$source_branch' → '$target_branch'?" --affirmative "Yes" --negative "No" || exit 0

# Spin animation
gum spin --spinner dot --title "Checking out '$source_branch'..." -- git checkout "$source_branch"

# Create PR
gum spin --spinner pulse --title "Creating pull request..." -- gh pr create \
	--base "$target_branch" \
	--head "$source_branch" \
	--title "$title" \
	--body "$description"

# Success message
gum style --foreground "$pink" --bold "✅ Pull request created successfully on GitHub!"
