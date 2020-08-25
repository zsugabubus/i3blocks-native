CFLAGS := -Wall -Ofast -std=c99 -Werror -Wextra -pedantic -D_GNU_SOURCE
CLIBS_volume := -lasound

SRCS = $(wildcard $(SRCDIR)/*.c)
TARGETS = $(patsubst $(SRCDIR)/%.c,%,$(SRCS))

SRCDIR := src
# XXX: Binaries should go to ~/.local/lib/arch-id/.
OUTDIR := scripts

RM := rm -f
STRIP := strip
STRIPFLAGS := -s -R .comment -R .gnu.version --strip-unneeded

all : $(TARGETS)

$(TARGETS) : %: $(OUTDIR)/%

$(OUTDIR)/% : $(SRCDIR)/%.c
	$(CC) $(CFLAGS) $(CLIBS_$(notdir $(basename $@))) $< $(SRCDIR)/fourmat/fourmat.c -o $@
	$(STRIP) $(STRIPFLAGS) $@

clean :
	$(RM) $(addprefix $(OUTDIR)/,$(TARGETS))

.PHONY : all clean $(TARGETS)
