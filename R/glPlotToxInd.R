#####################################################################
## This program is distributed in the hope that it will be useful, ##
## but WITHOUT ANY WARRANTY; without even the implied warranty of  ##
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the    ##
## GNU General Public License for more details.                    ##
#####################################################################

#-------------------------------------------------------------------------------
# glPlotToxInd: plot toxicological indicators
#-------------------------------------------------------------------------------

#' @title Plot toxicological indicator values for all chemicals in input
#' @description This function plots the toxicological indicator value for
#' the assay source id in input.
#'
#' @param asid assay source id
#' @param tp Time point to report
#' @param stat statistic to plot
#'
#' @details
#' This function is useful to plot toxicological indicator values. These
#' values, for each chemical, represent an average impact of the chemical
#' across the list of endpoints tested. The function transform the data to minus
#' log scale. Hence the larger the indicator value, larger is the impact of the
#' chemical.
#'
#' @examples
#' ## Store the current config settings, so they can be reloaded at the end
#' ## of the examples
#' conf_store <- gtoxConfList()
#' gtoxConfDefault()
#'
#' ## Compute and plot toxicological severity index
#' glPlotToxInd(asid=1L)
#' 
#' @return None
#'
#' @import ggplot2
#' @import ggrepel
#' @export
#'

glPlotToxInd <- function(asid, tp=NULL, stat=quote(modl_acc)) {

    dat <- glComputeToxInd(asid, tp=NULL, stat=quote(modl_acc))

    print(
        ggplot(dat, aes(x=chnm, y=V1)) +
        geom_point() +
        geom_label_repel(aes(label=chnm), size=7, data=dat, fill="gray80",
                    fontface="plain") +
        ylim(c(0,1)) +
        labs(x="Index", y="Severity score") +
        theme_minimal() +
        theme(legend.position="None",
            axis.title.x=element_text(size=14),
            axis.title.y=element_text(size=14),
            axis.text.y=element_text(size=14),
            axis.text.x=element_blank())
    )
}
