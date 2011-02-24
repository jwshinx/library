Feature: Comment
  To provide user opinions
  I want to add comments to each book

  Scenario: Add comment
    Given a book
    When a comment is added
    Then the book has an associated comment
