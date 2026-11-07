# Contributing Guidelines

Thank you for contributing to the **RoGameDev** project! This repository houses the development of an Indonesian life party board game on Roblox.

---

## 1. Development Principles

1. **Server-Authoritative:** All gameplay logic, money transactions, dice rolls, and turn progression must be validated on the server.
2. **Modular Architecture:** Keep services and controllers small, modular, and single-purpose. Avoid monolithic scripts.
3. **Configuration over Hardcoding:** Numerical balances, event definitions, and tuning values must reside in `src/Shared/Config/`.
4. **Zero Client Trust:** RemoteEvents and RemoteFunctions must always validate calling player permissions and debounces.

---

## 2. Git Workflow & Review Policy

- **No Blind Commits:** All code modifications must be reviewed, explained, and verified before committing.
- **Commit Message Convention:** Follow Conventional Commits format:
  - `feat: add dice investment calculation in EconomyService`
  - `fix: resolve turn timer desync during reconnect`
  - `docs: update OPEN_DECISIONS with loan interest rate`
  - `refactor: modularize board node definitions`
- **Branch Strategy:**
  - `main`: Production and stable milestone builds.
  - `dev`: Active integration branch.
  - `feature/<name>`: Isolated feature branches.
