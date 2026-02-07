
---
name: review-changes
description: Process and implement code review feedback systematically. Use when user provides reviewer comments, PR feedback, code review notes, or asks to implement suggestions from reviews.
---

# Review Feedback Implementation

Systematically process and implement changes based on code review feedback.

## When to Use

- Provides reviewer comments or feedback
- Pastes PR review notes
- Mentions implementing review suggestions
- Says "address these comments" or "implement feedback"
- Shares list of changes requested by reviewers

## Systematic Workflow

### 1. Parse Reviewer Notes

Identify individual feedback items:
- Split numbered lists (1., 2., etc.)
- Handle bullet points or unnumbered feedback
- Extract distinct change requests
- Clarify ambiguous items before starting

### 2. Create Todo List

Use TodoWrite tool to create actionable tasks:
- Each feedback item becomes one or more todos
- Break down complex feedback into smaller tasks
- Make tasks specific and measurable
- Mark first task as `in_progress` before starting

Example:
```
- Add type hints to extract function
- Fix duplicate tag detection logic
- Update docstring in chain.py
- Add unit test for edge case
```

## Important Guidelines

- **Always use TodoWrite** for tracking progress
- **Mark todos completed immediately** after each item
- **Ask questions** for unclear feedback
- **Run tests** if changes affect tested code
