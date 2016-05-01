Contributing to Exdash
======================

First off, Thanks for taking the time to contribute!

## Installing the project
### Prerequisites
Make sure the following is installed on your system:
- Elixir (>= 1.2)
- Erlang/OTP (18)

### Fork the project
Create a working copy by [forking](https://help.github.com/articles/fork-a-repo/) the repository.

### Installing dependencies
Navigate to the root of the project in your preferred terminal and execute `mix deps.get`.

## How can I contribute?
Glad you ask!

### Reporting bugs
This section guides you through submitting a bug report for Exdash. Following these guidelines helps maintainers and the community understand your report, reproduce the behavior, and find related reports.

#### How do I submit a good bug report?
Bugs are tracked as GitHub issues. After you've determined which repository your bug is related to, create an issue on that repository and provide the following information.

Explain the problem and include additional details to help maintainers reproduce the problem:

- **Use a clear and descriptive title** for the issue to identify the problem.
- **Provide specific examples to demonstrate the steps.**
- **Explain which behavior you expected to see instead and why.**

Include additional information:
- Which **version** of Exdash are you using?

#### Template for submittin a bug report
```
[Short description of problem here]

**Reproduction Steps:**

1. [First Step]
2. [Second Step]
3. [Other Steps...]

**Expected behavior:**

[Describe expected behavior here]

**Additional information:**

```

### Your first code contribution
Not sure where to start contributing? You can start by looking through the [`help wanted`](https://github.com/TFarla/exdash/issues?q=is%3Aissue+is%3Aopen+label%3A%22help+wanted%22) issues


### Pull Requests
- Please add documentation and at least one [`doctest`](http://elixir-lang.org/getting-started/mix-otp/docs-tests-and-with.html#doctests) to each function in your new code
- Include thoughtfully-worded well-structured [ExUnit](http://elixir-lang.org/docs/stable/ex_unit/ExUnit.html) tests in the `test` folder.


## Styleguides
### Git commit messages
- Use the present tense ("Add feature" not "Added feature")
- Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
- Limit the first line to 72 characters or less
- Reference issues and pull requests liberally
- Please execute `mix test && mix dogma` and fix any errors before committing any code
