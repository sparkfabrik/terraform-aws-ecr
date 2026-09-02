# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.2.0] - 2026-09-02

### Changed

- refs sparkfabrik-innovation-team/board#4811: lower `ecr_lifecycle_tagged_expiration_days` from 90 to 30 and `ecr_lifecycle_untagged_expiration_days` from 45 to 30. Consumers that need the previous retention must set both variables explicitly.

## [0.1.0] - 2025-10-08

- refs platform/board#3860: first release 🎉
