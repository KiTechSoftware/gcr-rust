# 🦀 GCR Rust Security Tools

A lightweight, CI-ready Docker image for Rust security and packaging tools — maintained by [Kitech Software](https://github.com/kitechsoftware).

Hosted on GitHub Container Registry:  
👉 [`ghcr.io/kitechsoftware/gcr-rust`](https://github.com/kitechsoftware/gcr-rust/pkgs/container/gcr-rust)

---

## 🚀 What's Inside

This image is designed for security scanning, cross-compilation, and packaging Rust applications in CI/CD.

### ✅ Included Tools

| Tool                    | Purpose |
| ----------------------- |---------|
| `cargo audit`           | Check for vulnerable crates (RustSec) |
| `cargo geiger`          | Detect `unsafe` code |
| `cargo deny`            | Enforce license & dependency policy |
| `cargo deb`             | Build `.deb` packages |
| `cargo generate-rpm`    | Build `.rpm` packages |
| `gcc-aarch64-linux-gnu` | Cross-compile to `aarch64` |

---

## 📂 Scripts Included

The following scripts are pre-installed in `/usr/local/bin`:

| Script         | Summary                                                                                             |
| -------------- | --------------------------------------------------------------------------------------------------- |
| unsafe-scan    | Scans for unsafe Rust code using `cargo geiger` and outputs a summary.                              |
| audit-deps     | Runs `cargo audit` and reports vulnerable dependencies.                                             |
| cargo-deny     | Runs `cargo deny check` for license, advisory, and policy violations.                               |
| security-check | Runs all security tools (`audit-deps`, `cargo-deny`, `unsafe-scan`) and combines results.           |
| bloat-report   | Analyzes binary size using `cargo bloat`.                                                           |
| ci-check       | Full CI pipeline: runs all checks (security, lint, format, tests, coverage) and aggregates results. |
| clippy-check   | Runs `cargo clippy` and fails on warnings.                                                          |
| fmt-check      | Checks formatting with `cargo fmt --check`.                                                         |
| nextest        | Runs tests using `cargo nextest`.                                                                   |
| outdated-deps  | Checks for outdated dependencies using `cargo outdated`.                                            |
| test-coverage  | Generates test coverage reports using `cargo llvm-cov`.                                             |

> All scripts support the `--no-fail` flag to allow soft enforcement.

---

## 🧪 Example GitHub Actions Usage

```yaml
jobs:
  security:
    runs-on: ubuntu-latest
    container:
      image: ghcr.io/kitechsoftware/gcr-rust:latest

    steps:
      - uses: actions/checkout@v4

      - name: Run All Security Checks
        run: security-check --no-fail

      - name: Upload Security Report
        uses: actions/upload-artifact@v4
        with:
          name: security-summary
          path: security-summary.md
```

---

## 🖥️ Local Usage

You can also run the tools locally with Docker:

```bash
docker run --rm -v "$PWD":/usr/src/app -w /usr/src/app ghcr.io/kitechsoftware/gcr-rust:latest security-check
```

---

## 🛠️ Building the Image Locally

```bash
docker build -t gcr-rust -f .docker/Dockerfile.security .
```

---

## 🤝 Contributing

Contributions are welcome! Feel free to submit issues, pull requests, or ideas.

---

## 📄 License

[MIT](LICENSE)
