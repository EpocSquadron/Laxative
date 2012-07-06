# Laxative

Laxative is a simple, yet tasteful script for standardizing MySQL database dumps in a more digestable manner suitable for your daily development needs. Laxative allows you to take a load off, easier than ever before! It is meant to make db dumps as git trackable, lightweight, odorless, and easy to import into any environment as possible.

## Requirements

A working installation (findable in BASH's PATH) of the following:

 - mysql (& mysqldump)
 - sed (BSD or GNU)
 - grep

### Note to MAMP Users

If you have not already, you need to make bash able to find the mysqldump command.  This is hidden away inside nonstandard directories in MAMP. An easy solution is to create a symlink to the standard directory:

    ln -s /Applications/MAMP/Library/bin/mysqldump /usr/local/bin/mysqldump

Or add the MAMP MySQL binaries to your PATH in ~/.bash_profile:

    PATH=$PATH:/Applications/MAMP/Library/bin


## Installation

Simply copy lax to it's own directory inside the root of your project.  Laxative will save and load databases from that directory. Configuration for each environment will either be inherited from your ee-master-config configuration, or from .conf files in it's own directory matching the syntax of template.conf.


## Usage

Laxative works via the script `lax`, which accepts a command followed by an "environment shortname".  The environment shortname is the abbreviation by which you name the configuration files for accessing your database.

### Take a Dump

    lax dump <environment_shortname>

### [Load a Dump](http://www.urbandictionary.com/define.php?term=two+girls+one+cup)

    lax load <environment_shortname>

### Replace One Environment's Dump with Another's

    lax usurp <from_environment_shortname> <to_environment_shortname>

## Not Completely Satisfied?

Send a pull request, a stool sample, and $9.99 for processing with your additions. (The latter two are *optional*)

## Warranty

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY SLOPPY MESSES, DAMAGES OR OTHER BATHROOM LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE, RESTROOMS, OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. CONSULT YOUR PHYSICIAN FOR MORE INFORMATION ON LAXATIVE. COMMON SIDE EFFECTS INCLUDE DRY MOUTH, IRRITATION AND DIFFICULTY STRUGGLING TO CONTROL YOUR DATABASE. IN RARE CASES, SOME PEOPLE REPORT ACTUALLY BEING ABLE TO SLEEP AT NIGHT KNOWING THEIR DATABASES ARE BACKED UP WITH GIT. YOUR INDIVIDUAL RESULTS MAY VARY. NOT AVAILABLE IN ALL AREAS. CALL YOUR LOCAL CABLE PROVIDER.
