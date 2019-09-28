CFLAGS:=-Wall -Ofast -std=c99 -Werror -Wextra -pedantic -D_GNU_SOURCE
CLIBS_volume:=-lasound

SRCS=$(wildcard $(SRCDIR)/*.c)
TARGETS=$(patsubst $(SRCDIR)/%.c,%,$(SRCS))

SRCDIR:=src
# XXX: Binaries should go to ~/.local/lib/arch-id/.
OUTDIR:=scripts

RM:=/usr/bin/rm
STRIP:=/usr/bin/strip
STRIPFLAGS:=-s -R .comment -R .gnu.version --strip-unneeded

.PHONY: all
all: $(TARGETS)

.PHONY: $(TARGETS)
$(TARGETS): %: $(OUTDIR)/%

$(OUTDIR)/%: $(SRCDIR)/%.c
	$(CC) $(CFLAGS) $(CLIBS_$(notdir $(basename $@))) $< -o $@
	$(STRIP) $(STRIPFLAGS) $@

.PHONY: clean
clean:
	$(RM) $(addprefix $(OUTDIR)/,$(TARGETS))
